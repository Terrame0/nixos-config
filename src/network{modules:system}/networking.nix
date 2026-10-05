{host, ...}: {
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
    };
    firewall = {
      trustedInterfaces = ["tun0"];
      # -- MoIP (Morse over IP) chat server
      allowedUDPPorts = [7890];
    };
  };
}
