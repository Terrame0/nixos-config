{config, ...}: {
  boot.supportedFilesystems.zfs = true;
  #boot.zfs.package = config.boot.kernelPackages.zfs_cachyos;
}
