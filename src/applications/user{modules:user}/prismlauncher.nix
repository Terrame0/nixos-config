{pkgs, ...}: {
  sing-box.proxied-domains = [
    "modrinth.com"
    "curseforge.com"
    "minecraft.net"
  ];
  home.packages = [
    (pkgs.prismlauncher.override {
      additionalLibs = [
        pkgs.cudaPackages.cudatoolkit
        pkgs.cudaPackages.cudnn
      ];
    })
  ];
}
