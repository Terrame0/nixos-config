{
  config,
  pkgs,
  lib,
  ...
}: let
  skeleton = (pkgs.formats.json {}).generate "sing-box-skeleton.json" {
    log = {
      level = "info";
      timestamp = true;
    };
    dns = {
      servers = [
        {
          tag = "remote-dns";
          type = "tls";
          server = "1.1.1.1";
          detour = "auto-selector";
        }
        {
          tag = "local-dns";
          type = "local";
        }
        {
          tag = "fakeip";
          type = "fakeip";
          inet4_range = "198.18.0.0/15";
          inet6_range = "fc00::/18";
        }
      ];
      rules = [
        {
          query_type = ["A" "AAAA"];
          server = "fakeip";
          rewrite_ttl = 1;
        }
      ];
      final = "remote-dns";
      independent_cache = true;
    };
    inbounds = [
      {
        type = "tun";
        tag = "tun-in";
        address = ["172.19.0.1/30" "fdfe:dcba:9876::1/126"];
        mtu = 1500;
        auto_route = true;
        strict_route = true;
        stack = "mixed";
        endpoint_independent_nat = true;
      }
    ];
    outbounds = [
      {
        type = "urltest";
        tag = "auto-selector";
        outbounds = []; # -- placeholder
        url = "https://www.gstatic.com/generate_204";
        interval = "5m";
        tolerance = 50;
        idle_timeout = "30m";
      }
      {
        type = "direct";
        tag = "direct";
      }
    ];
    route = {
      rules = [
        {action = "sniff";}
        {
          type = "logical";
          mode = "or";
          rules = [{protocol = "dns";} {port = 53;}];
          action = "hijack-dns";
        }
        {
          ip_is_private = true;
          outbound = "direct";
        }
      ];
      final = "auto-selector";
      default_domain_resolver = "local-dns";
      auto_detect_interface = true;
    };
    experimental.cache_file = {
      enabled = true;
      path = "/var/lib/sing-box/cache.db";
      store_fakeip = true;
    };
  };

  options = {
    state-dir = "/var/lib/sing-box";
    runtime-dir = "/run/sing-box";
  };
  update-script = pkgs.writeShellApplication {
    name = "sing-box-update";
    runtimeInputs = [pkgs.curl pkgs.jq pkgs.sing-box pkgs.coreutils];

    text = ''      
      HWID="$(cat ${config.sops.secrets."vpn/hwid".path})"
      SUB_URL="$(cat ${config.sops.secrets."vpn/sub-url".path})"
      LIVE="${options.state-dir}/config.json"
      RUNTIME="${options.runtime-dir}/config.json"

      mkdir -p "${options.state-dir}" "${options.runtime-dir}"

      filter='[.outbounds[] | select(.flow == "xtls-rprx-vision" and (.transport | not))]'

      update_ok=false
      if curl -fsS --retry 3 --retry-delay 2 --max-time 40 \
           -A 'singbox' -H "x-hwid: $HWID" "$SUB_URL" -o "${options.runtime-dir}/sub.json"; then

        count="$(jq "$filter | length" "${options.runtime-dir}/sub.json")"
        if [ "$count" -ge 1 ]; then
          TMP="$(mktemp)"
          jq --slurpfile sub "${options.runtime-dir}/sub.json" '
            ($sub[0].outbounds | map(select(.flow == "xtls-rprx-vision" and (.transport | not)))) as $nodes
            | ($nodes | map(.tag)) as $tags
            | .outbounds = (.outbounds | map(if .tag == "auto-selector" then .outbounds = $tags else . end)) + $nodes
          ' ${skeleton} > "$TMP"

          if sing-box check -c "$TMP"; then
            mv "$TMP" "$LIVE"     # обновляем persistent-кеш
            update_ok=true
          else
            echo "WARN: check не прошёл, оставляю прошлый конфиг" >&2
            rm -f "$TMP"
          fi
        else
          echo "WARN: фильтр вернул 0 узлов, оставляю прошлый конфиг" >&2
        fi
      else
        echo "WARN: подписка недоступна, оставляю прошлый конфиг" >&2
      fi

      # выбираем, что отдать ядру: свежее или прошлое
      if [ "$update_ok" = true ]; then
        cp "$LIVE" "$RUNTIME"
      elif [ -f "$LIVE" ]; then
        echo "INFO: стартую на прошлом сохранённом конфиге" >&2
        cp "$LIVE" "$RUNTIME"
      else
        echo "FATAL: нет ни свежего, ни сохранённого конфига" >&2
        exit 1
      fi'';
  };
in {
  systemd.services.sing-box = {
    description = "sing-box (subscription-driven)";
    after = ["network-online.target" "sops-nix.service"];
    wants = ["network-online.target"];
    requires = ["sops-nix.service"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStartPre = lib.getExe update-script;
      ExecStart = "${pkgs.sing-box}/bin/sing-box run -c /run/sing-box/config.json";
      ExecReload = "/bin/kill -HUP $MAINPID";
      Restart = "on-failure";
      RestartSec = "10s";
      LimitNOFILE = "infinity";

      RuntimeDirectory = "sing-box";
      RuntimeDirectoryMode = "0700";
      StateDirectory = "sing-box";
      StateDirectoryMode = "0700";

      CapabilityBoundingSet = ["CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE"];
      AmbientCapabilities = ["CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE"];
    };
  };
}
