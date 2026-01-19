{...}: {
  # -- opengl configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # -- xserver
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  # -- nvidia configuration
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = true;
    forceFullCompositionPipeline = true;
  };
}
