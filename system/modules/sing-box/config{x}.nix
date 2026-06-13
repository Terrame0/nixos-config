{
  paths,
  pkgs,
  ...
}:
(pkgs.formats.json {}).generate
"sing-box-config.json" {
  log = {
    level = "debug";
    timestamp = true;
  };
  dns = {
    servers = [
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
  outbounds = [
    {
      type = "urltest";
      tag = "auto-selector";
      outbounds = []; # -- placeholder
      url = "https://www.gstatic.com/generate_204";
      interval = "5m";
      tolerance = 50;
      idle_timeout = "30m";
    }
    {
      type = "direct";
      tag = "direct";
    }
  ];
  route = {
    rules = [
      # -- default actions
      {action = "sniff";}
      {
        type = "logical";
        mode = "or";
        rules = [{protocol = "dns";} {port = 53;}];
        action = "hijack-dns";
      }
      {
        protocol = "quic";
        action = "reject";
      }
      {
        ip_is_private = true;
        outbound = "direct";
      }
      # -- routing rules
      {
        domain_keyword = ["claude"];
        outbound = "auto-selector";
      }
      {
        domain_suffix = ["youtube.com" "googlevideo.com" "ytimg.com" "ggpht.com"];
        outbound = "direct";
      }
      {
        rule_set = ["refilter-domains" "refilter-ipsum"];
        outbound = "auto-selector";
      }
    ];
    final = "auto-selector";
    default_domain_resolver = "remote-dns";
    auto_detect_interface = true;
    rule_set = [
      {
        tag = "refilter-domains";
        type = "remote";
        format = "binary";
        url = "https://github.com/1andrevich/Re-filter-lists/releases/latest/download/ruleset-domain-refilter_domains.srs";
        download_detour = "auto-selector";
      }
      {
        tag = "refilter-ipsum";
        type = "remote";
        format = "binary";
        url = "https://github.com/1andrevich/Re-filter-lists/releases/latest/download/ruleset-ip-refilter_ipsum.srs";
        download_detour = "auto-selector";
      }
    ];
  };

  experimental.cache_file = {
    enabled = true;
    path = "${paths.state-dir}/cache.db";
    store_fakeip = true;
  };
}
