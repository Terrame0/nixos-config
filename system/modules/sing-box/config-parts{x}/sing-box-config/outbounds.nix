{...}: {
  outbounds = [
    {
      type = "selector";
      tag = "proxy";
      # -- ahead of the urltest so it can be pinned to a node via clash-api when metadata lies
      outbounds = ["auto-selector"];
      default = "auto-selector";
    }
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
}
