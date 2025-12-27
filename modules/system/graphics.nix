{...}: {
  # -- opengl configuration
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # -- nvidia configuration
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
  };
}
