{pkgs, ...}: {
  sing-box.proxied-domains = [
    "modrinth.com"
    "curseforge.com"
    "minecraft.net"
  ];
  home.packages = with pkgs; [
    prismlauncher
    # -- was needed for diffusion terrain generation mod
    # (prismlauncher.override {
    #   additionalLibs = [
    #     cudaPackages.cudatoolkit
    #     cudaPackages.cudnn
    #   ];
    # })
  ];
}
