{paths, ...}: {
  route = {
    rules = [
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
      {
        domain_suffix = import "${paths.parts-dir}/proxied-domains.nix";
        outbound = "proxy";
      }
      {
        rule_set = ["refilter-domains" "refilter-ipsum"];
        outbound = "proxy";
      }
    ];
    final = "direct";
    default_domain_resolver = "local-dns";
    auto_detect_interface = true;
    rule_set = [
      {
        tag = "refilter-domains";
        type = "remote";
        format = "binary";
        url = "https://github.com/1andrevich/Re-filter-lists/releases/latest/download/ruleset-domain-refilter_domains.srs";
        download_detour = "direct";
      }
      {
        tag = "refilter-ipsum";
        type = "remote";
        format = "binary";
        url = "https://github.com/1andrevich/Re-filter-lists/releases/latest/download/ruleset-ip-refilter_ipsum.srs";
        download_detour = "direct";
      }
    ];
  };
}
