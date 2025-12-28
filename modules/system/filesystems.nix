{...}: {
  fileSystems."/mnt/windows" = {
    device = "/dev/disk/by-uuid/0CDED814DED7F444";
    fsType = "ntfs";
    options = [
      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };
}
