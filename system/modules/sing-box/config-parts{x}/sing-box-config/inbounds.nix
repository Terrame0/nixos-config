{...}: {
  inbounds = [
    {
      type = "tun";
      tag = "tun-in";
      address = ["172.19.0.1/30"];
      mtu = 1500;
      auto_route = true;
      strict_route = true;
      stack = "mixed";
      endpoint_independent_nat = true;
    }
  ];
}
