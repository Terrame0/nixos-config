{...}: {}
# inbounds = [{
#   type = "tun";
#   tag = "tun-in";
#   address = ["172.19.0.1/30"];
#   mtu = 1500;
#   auto_route = true;
#   strict_route = true;
#   stack = "mixed";
#   endpoint_independent_nat = true;
#   route_exclude_address_set = ["geoip-google"];
# }];
#
# route.rule_set = [
#   {
#     tag = "geoip-google";
#     type = "remote";
#     format = "binary";
#     url = "https://raw.githubusercontent.com/Chocolate4U/Iran-sing-box-rules/rule-set/geoip-google.srss";
#     download_detour = "auto-selector";
#   }
#   # ... refilter-наборы ...
# ];

