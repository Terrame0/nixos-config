{...}: {
  networking = {
    # nameservers = ["8.8.8.8" "8.8.4.4"];
    networkmanager.enable = true;
    # -- nix breaks if system proxy is enabled
    # proxy = {
    #   default = "http://127.0.0.1:10808";
    #   noProxy = "127.0.0.1,localhost,192.168.0.0/16,10.0.0.0/8"; # -- failsafe
    # };
  };
}
