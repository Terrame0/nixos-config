{...}: {
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        "10-default-policy" = {
          "wireplumber.settings" = {
            "stream.restore-target" = false;
            "stream.restore-props" = true;
            "device.restore-profile" = true;
            "device.restore-routes" = true;
          };
        };
        "51-lower-priorities" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {"node.name" = "~alsa_output.pci-.*analog.*";}
                {"node.name" = "~alsa_input.pci-.*analog.*";}
              ];
              actions.update-props."priority.session" = 100;
            }
            {
              matches = [
                {"node.name" = "~alsa_output.pci-.*hdmi.*";}
              ];
              actions.update-props."priority.session" = 50;
            }
          ];
        };
      };
    };
  };
}
