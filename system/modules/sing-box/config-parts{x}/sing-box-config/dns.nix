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
        detour = "auto-selector";
      }
      {
        tag = "fakeip";
        type = "fakeip";
        inet4_range = "198.18.0.0/15";
      }
    ];
    rules = [
      # The urltest probe host must resolve to a real address, otherwise it
      # gets a fakeip and the connect loops back into the router before
      # auto-selector has picked a node (deadlock). Node server domains are
      # already resolved by the outbound dialer via default_domain_resolver,
      # so they don't need listing here.
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
