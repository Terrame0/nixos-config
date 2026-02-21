{...}: {
  # -- opengl configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
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
}
