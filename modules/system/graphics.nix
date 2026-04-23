{...}: {
  # -- opengl configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # -- nvidia configuration
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    open = false;
  };

  # -- it appears that these are not needed as of now
  environment.variables = {
    # -- force the use of nvidia drivers
    #LIBVA_DRIVER_NAME = "nvidia";
    #__GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
