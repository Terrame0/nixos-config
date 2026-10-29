{host, ...}: {
  # -- cloudflare does not resolve sometimes
  sing-box.proxied-domains = ["cloudflare.com"];
  networking = {
    hostName = host.name;
    # -- 1.1.1.1 and 8.8.8.8 forward this subnet via EDNS Client Subnet, so Cloudflare
    # - answers *.cachix.org with 8.6.112.5, throttled to ~90 B/s here, which stalls
    # - every rebuild. Quad9 omits the subnet and gets a different, unthrottled edge.
    nameservers = [
      "9.9.9.9" # -- quad9 primary
      "149.112.112.112" # -- quad9 secondary
      "1.1.1.1" # -- subnet-aware, throttled edge
      "8.8.8.8" # -- last resort
    ];
    networkmanager = {
      enable = true;
      dns = "none";
      # -- debounce transient ethernet carrier loss
      settings."device-ethernet" = {
        match-device = "type:ethernet";
        carrier-wait-timeout = 15000;
      };
      # -- PPPoE on the router eats 8 bytes, so the path carries 1492, not 1500.
      # -- Oversized packets are dropped silently (no ICMP back), stalling TCP mid-stream.
      settings."connection-ethernet" = {
        match-device = "type:ethernet";
        "ethernet.mtu" = 1492;
      };
    };
    firewall = {
      trustedInterfaces = ["tun0"];
      # -- MoIP (Morse over IP) chat server
      allowedUDPPorts = [7890];
    };
  };
}
