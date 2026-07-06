{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_7_0;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
