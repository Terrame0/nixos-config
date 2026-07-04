{...}: {
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
}
