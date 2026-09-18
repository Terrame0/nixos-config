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
            text =
              # -< nushell >-
              ''
                def main [iface: string, action: string] {
                  if $action not-in ["up" "down"] { return }
                  let wired = ^nmcli -t -f TYPE,STATE device status
                    | complete | get stdout | lines
                    | any {|line| $line == "ethernet:connected" }
                  if $wired {^nmcli radio wifi off | complete | ignore}
                  else {^nmcli radio wifi on | complete | ignore}
                }
              '';
          });
        }
      ];
    };
    firewall = {
      trustedInterfaces = ["tun0"];
    };
  };
}
