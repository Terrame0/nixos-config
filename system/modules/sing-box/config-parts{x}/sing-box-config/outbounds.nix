{...}: {
  outbounds = [
    {
      type = "selector";
      tag = "proxy";
      # -- ahead of the urltest so it can be pinned to a node via clash-api when metadata lies
      outbounds = ["auto-selector" "dummy"];
      default = "auto-selector";
    }
    {
      type = "urltest";
      tag = "auto-selector";
      # -- placeholder node, the updater swaps it for real nodes
      outbounds = ["dummy"];
      url = "https://www.gstatic.com/generate_204";
      interval = "5m";
      tolerance = 50;
      idle_timeout = "30m";
    }
    ({type = "direct";} // {tag = "direct";})
    # -- keeps the selectors non-empty so the bare skeleton passes 'sing-box check'
    # -- the updater strips it once real nodes are merged in
    ({type = "direct";} // {tag = "dummy";})
  ];
}
