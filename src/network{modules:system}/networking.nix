{
  host,
  pkgs,
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
          source = pkgs.writeShellScript "70-wifi-wired-exclusive" ''
            export LC_ALL=C

            case "$2" in
              up|down)
                if ${pkgs.networkmanager}/bin/nmcli -t -f TYPE,STATE device status \
                  | ${pkgs.gnugrep}/bin/grep -qx 'ethernet:connected'; then
                  ${pkgs.networkmanager}/bin/nmcli radio wifi off
                else
                  ${pkgs.networkmanager}/bin/nmcli radio wifi on
                fi
                ;;
            esac
          '';
        }
      ];
    };
    firewall = {
      trustedInterfaces = ["tun0"];
    };
  };
}
