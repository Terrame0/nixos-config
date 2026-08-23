{pkgs, ...}: {
  boot = {
    kernelPackages =
      pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
    kernelModules = [
      "ntsync" # -- to improve windows compat layer performance
      "tcp_bbr3" # -- tcp congestion control
      "sch_fq" # -- qdisc fair queue
    ];
  };
}
