{pkgs, ...}: {
  boot = {
    kernelPackages =
      pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
    kernelParams = [
      # -- we have to override this as the cachyos kernel
      # - is built with "zswap.enabled=1" for some reason
      # - ("boot.zswap.enable = false" does not override this)
      "zswap.enabled=0"
    ];
    kernelModules = [
      "ntsync" # -- to improve windows compat layer performance
      "tcp_bbr3" # -- tcp congestion control
      "sch_fq" # -- qdisc fair queue
    ];
  };
}
