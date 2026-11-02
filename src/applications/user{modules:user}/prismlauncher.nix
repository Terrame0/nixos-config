{pkgs, ...}: {
  vpn.domain-list = [
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
