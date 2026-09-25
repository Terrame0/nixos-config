{pkgs, ...}: {
  home.packages = [
    (pkgs.prismlauncher.override {
      additionalLibs = [
        pkgs.cudaPackages.cudatoolkit
        pkgs.cudaPackages.cudnn
      ];
    })
  ];
}
