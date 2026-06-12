{host, ...}: {
  networking = {
    hostName = host.name;
    nameservers = ["1.1.1.1" "8.8.8.8" "8.8.4.4"];
    networkmanager = {
      enable = true;
      dns = "none";
    };
    firewall = {
      allowedTCPPorts = [5432];
      trustedInterfaces = ["tun0"];
    };
  };
}
