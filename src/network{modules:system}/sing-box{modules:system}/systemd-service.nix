args @ {
  config,
  pkgs,
  lib,
  config-root,
  ...
}: let
  paths = rec {
    parts-dir = "${config-root}/system/modules{modules:system}/sing-box/config-parts{x}";
    base-dir = "sing-box";
    state-dir = "/var/lib/${base-dir}";
    runtime-dir = "/run/${base-dir}";
    response-file = "${runtime-dir}/response.json";
    stored-config = "${state-dir}/config.json";
    runtime-config = "${runtime-dir}/config.json";
  };
  skeleton =
    import
    "${paths.parts-dir}/sing-box-config"
    (args // {inherit paths;});
  update-script =
    import
    "${paths.parts-dir}/updater"
    (args
      // {
        inherit paths;
        inherit skeleton;
      });
in {
  systemd.services.sing-box = {
    description = "a sing-box proxy client";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStartPre = lib.getExe update-script;
      ExecStart = "${lib.getExe pkgs.sing-box} run -c ${paths.runtime-config}";
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
