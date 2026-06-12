{host, ...}: {
  networking = {
    hostName = host.name;
    nameservers = ["8.8.8.8" "8.8.4.4" "1.1.1.1"];
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [5432];
      trustedInterfaces = ["tun0"];
    };
  };
}
