{...}: {
  # The auto-selector's `outbounds` list is a placeholder: the subscription
  # updater fills it with the node tags pulled from the subscription.
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
