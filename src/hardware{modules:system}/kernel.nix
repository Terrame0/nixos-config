{pkgs, ...}: {
  boot = {
    kernelPackages =
      pkgs.linuxPackages_latest;
    #pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
    #kernelModules = [
    #  "ntsync"
    #  "tcp_bbr3"
    #  "sch_fq"
    #];
  };
}
