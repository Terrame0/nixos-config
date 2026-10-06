{
  host,
  pkgs,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      vhostUserPackages = [pkgs.virtiofsd];
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;

  users.users.${host.username}.extraGroups = ["libvirtd"];
}
