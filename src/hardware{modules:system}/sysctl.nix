{...}: {
  boot.kernel.sysctl = {
    # -- qdisc fair queue and tcp congestion control
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr3";

    # -- lower values make the fs cache stay in ram longer
    "vm.vfs_cache_pressure" = 10;

    # -- the system will try to move cold memory
    # - into the zram more agressively
    "vm.swappiness" = 150;

    # -- disables memory page readahead
    # - (advantageous for zram)
    "vm.page-cluster" = 0;
  };
}
