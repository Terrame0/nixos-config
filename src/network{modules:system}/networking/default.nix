{
  host,
  pkgs,
  lib,
  ...
}: {
  networking = {
    hostName = host.name;
    nameservers = ["1.1.1.1" "8.8.8.8" "8.8.4.4"];
    networkmanager = {
      enable = true;
      dns = "none";
      # -- debounce transient ethernet carrier loss
      settings."device-ethernet" = {
        match-device = "type:ethernet";
        carrier-wait-timeout = 15000;
      };
      # -- keep wifi inactive while ethernet is connected
      dispatcherScripts = [
        {
          type = "basic";
          source = lib.getExe (pkgs.nuenv.writeShellApplication {
            name = "70-wifi-wired-excl";
            runtimeInputs = [pkgs.networkmanager];
            text = builtins.readFile ./wifi-wired-excl.nu;
          });
        }
      ];
    };
    firewall = {
      trustedInterfaces = ["tun0"];
    };
  };
}
