{...}: {
  inbounds = [
    {
      type = "tun";
      tag = "tun-in";
      address = ["172.19.0.1/30"];
      # -- headroom for VLESS/TLS/gRPC overhead over the 1492-byte physical path
      mtu = 1400;
      auto_route = true;
      strict_route = true;
      stack = "mixed";
      endpoint_independent_nat = true;
    }
  ];
}
