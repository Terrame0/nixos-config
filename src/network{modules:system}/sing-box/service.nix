args' @ {
  sundry,
  config,
  pkgs,
  lib,
  root-vfs,
  ...
}: let
  config-subtree = sundry.vfs.dir.get ./config root-vfs;
  args = args' // {inherit config-subtree paths skeleton;};
  paths = rec {
    base-dir = "sing-box";
    state-dir = "/var/lib/${base-dir}";
    runtime-dir = "/run/${base-dir}";
    response-file = "${runtime-dir}/response.json";
    stored-config = "${state-dir}/config.json";
    runtime-config = "${runtime-dir}/config.json";
  };
  skeleton = lib.pipe config-subtree.sing-box-config [
    (sundry.vfs.dir.collapse (path: file: file.expr args))
    sundry.attrs.merge.recursive.no-collision
    ((pkgs.formats.json {}).generate "sing-box-config.json")
  ];
  update-script = config-subtree.updater."default.nix".expr args;
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
      # -- auto_detect_interface binds direct UDP sockets to the physical NIC via SO_BINDTODEVICE
      # - CAP_NET_RAW is required for the bind; without it UDP fails with EPERM
      CapabilityBoundingSet = ["CAP_NET_ADMIN" "CAP_NET_RAW" "CAP_NET_BIND_SERVICE"];
      AmbientCapabilities = ["CAP_NET_ADMIN" "CAP_NET_RAW" "CAP_NET_BIND_SERVICE"];
    };
  };
}
