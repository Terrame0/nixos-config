{host, ...}: {
  networking = {
    hostName = host.name;
    nameservers = ["1.1.1.1" "8.8.8.8" "8.8.4.4"];
    networkmanager = {
      enable = true;
      dns = "none";
    };
    firewall = {
      trustedInterfaces = ["tun0"];
    };
  };
}
