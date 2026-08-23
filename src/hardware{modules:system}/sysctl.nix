{...}: {
  boot.kernel.sysctl = {
    # -- qdisc fair queue and tcp congestion control
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr3";

    "vm.vfs_cache_pressure" = 50;

    # -- the system will try to move cold memory
    # - into the zram more agressively
    "vm.swappiness" = 120;
    # -- disables memory page readahead
    # - (advantageous for zram)
    "vm.page-cluster" = 0;
  };
}
