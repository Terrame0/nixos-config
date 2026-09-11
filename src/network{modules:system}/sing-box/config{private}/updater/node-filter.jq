def is_node: .type == "vless" and .tls.reality.enabled? == true and .flow? == "xtls-rprx-vision";
($response[0].outbounds | map(select(is_node))) as $nodes
| if ($nodes | length) < 1
  then error("0 nodes matched filter")
  else . end
| ($nodes | map(.tag)) as $tags
| .outbounds = ((.outbounds | map(
    if   .tag == "auto-selector" then .outbounds = $tags
    elif .tag == "proxy"         then .outbounds = ((.outbounds - ["dummy"]) + $tags)
    else . end))
    | map(select(.tag != "dummy")))
  + $nodes
