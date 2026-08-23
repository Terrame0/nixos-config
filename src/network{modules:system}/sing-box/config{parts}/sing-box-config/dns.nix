{...}: {
  dns = {
    servers = [
      {
        tag = "local-dns";
        type = "local";
      }
      {
        tag = "remote-dns";
        type = "tls";
        server = "1.1.1.1";
        detour = "proxy";
      }
      {
        tag = "fakeip";
        type = "fakeip";
        inet4_range = "198.18.0.0/15";
      }
    ];
    rules = [
      {
        domain = ["www.gstatic.com"];
        server = "local-dns";
      }
      {
        query_type = ["A" "AAAA"];
        server = "fakeip";
        rewrite_ttl = 300;
      }
    ];
    strategy = "ipv4_only";
    final = "remote-dns";
    independent_cache = true;
  };
}
