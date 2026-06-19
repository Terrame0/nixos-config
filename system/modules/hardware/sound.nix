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
        "10-no-state-persistence" = {
          "wireplumber.profiles" = {
            main = {
              "hooks.default-nodes.state" = "disabled";
              "hooks.stream.state" = "disabled";
            };
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
