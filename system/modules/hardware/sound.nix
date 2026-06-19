{...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig."51-lower-builtin-priority" = {
        "monitor.alsa.rules" = [
          {
            matches = [{"node.name" = "~alsa_output.pci-.*analog.*";}];
            actions.update-props."priority.session" = 100;
          }
        ];
      };
    };
  };
}
