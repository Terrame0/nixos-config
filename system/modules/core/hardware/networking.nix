{host, ...}: {
  networking = {
    hostName = host.name;
    nameservers = ["8.8.8.8" "8.8.4.4" "1.1.1.1"];
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [5432];
    proxy = {
      default = "http://127.0.0.1:8080";
      noProxy = "127.0.0.1,localhost,192.168.0.0/16,10.0.0.0/8"; # -- failsafe
    };
  };
}
