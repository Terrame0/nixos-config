{
  config,
  pkgs,
  lib,
  ...
}: let
  paths = rec {
    base-dir = "sing-box";
    state-dir = "/var/lib/${base-dir}";
    runtime-dir = "/run/${base-dir}";
    response-file = "${runtime-dir}/response.json";
    stored-config = "${state-dir}/config.json";
    runtime-config = "${runtime-dir}/config.json";
  };

  skeleton = (pkgs.formats.json {}).generate "sing-box-skeleton.json" {
    log = {
      level = "debug";
      timestamp = true;
    };
    dns = {
      servers = [
        {
          tag = "local-dns";
          type = "local";
        }
        {
          tag = "fakeip";
          type = "fakeip";
          inet4_range = "198.18.0.0/15";
        }
      ];
      rules = [
        {
          query_type = ["A" "AAAA"];
          server = "fakeip";
          rewrite_ttl = 300;
        }
      ];
      strategy = "ipv4_only";
      final = "local-dns";
      independent_cache = true;
    };
    inbounds = [
      {
        type = "tun";
        tag = "tun-in";
        address = ["172.19.0.1/30"];
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
          protocol = "quic";
          action = "reject";
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
      path = "${paths.state-dir}/cache.db";
      store_fakeip = true;
    };
  };

  update-script = pkgs.writeShellApplication {
    name = "sing-box-update";
    runtimeInputs = [pkgs.curl pkgs.jq pkgs.sing-box pkgs.coreutils];
    text = ''          
      DO_UPDATE=false
      if curl -sS \
        --connect-timeout 15 --max-time 40 \
        -H "x-hwid: $(cat "$CREDENTIALS_DIRECTORY/hwid")" \
        -H "x-device-os: Linux" \
        -H "x-ver-os: 1.0.0" \
        -H "x-device-model: Computer" \
        -A 'singbox' \
        "$(cat "$CREDENTIALS_DIRECTORY/sub-url")" \
        -o "${paths.response-file}";
      then
        TMP="$(mktemp)"
        if jq --slurpfile response "${paths.response-file}" '
            def is_node: .type == "vless" and .tls.reality.enabled? == true and .flow? == "xtls-rprx-vision";
            ($response[0].outbounds | map(select(is_node))) as $nodes
            | if ($nodes | length) < 1
              then error("0 nodes matched filter")
              else . end
            | ($nodes | map(.tag)) as $tags
            | .outbounds = (.outbounds | map(if .tag == "auto-selector" then .outbounds = $tags else . end)) + $nodes
          ' ${skeleton} > "$TMP";
        then
          if sing-box check -c "$TMP"; then
            mv "$TMP" "${paths.stored-config}"
            DO_UPDATE=true
          else
            echo "WARN: the configuration didn't pass the check, falling back to the last valid configuration" >&2
            rm -f "$TMP"
          fi
        else 
          echo "WARN: merge failed (no matching nodes?), falling back" >&2
          rm -f "$TMP"
        fi
      else
        echo "WARN: subscription server not responding, falling back to the last valid configuration" >&2
      fi
      rm -f "${paths.response-file}"
      if [ "$DO_UPDATE" = true ]; then
        cp "${paths.stored-config}" "${paths.runtime-config}"
      elif [ -f "${paths.stored-config}" ]; then
        echo "INFO: using the last valid configuration" >&2
        cp "${paths.stored-config}" "${paths.runtime-config}"
      else
        echo "FATAL: no valid configuration found" >&2
        exit 1
      fi'';
  };
in {
  systemd.services.sing-box = {
    description = "sing-box";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStartPre = lib.getExe update-script;
      ExecStart = "${pkgs.sing-box}/bin/sing-box run -c ${paths.runtime-config}";
      LoadCredential = [
        "sub-url:${config.sops.secrets."vpn/sub-url".path}"
        "hwid:${config.sops.secrets."vpn/hwid".path}"
      ];
      Restart = "on-failure";
      RestartSec = "10s";
      LimitNOFILE = "infinity";
      RuntimeDirectory = paths.base-dir;
      RuntimeDirectoryMode = "0700";
      StateDirectory = paths.base-dir;
      StateDirectoryMode = "0700";
      CapabilityBoundingSet = ["CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE"];
      AmbientCapabilities = ["CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE"];
    };
  };
}
