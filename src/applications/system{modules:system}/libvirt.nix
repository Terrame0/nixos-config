{host, ...}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };

  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  users.users.${host.username}.extraGroups = ["libvirtd"];
}
