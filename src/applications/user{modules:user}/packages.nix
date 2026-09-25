{pkgs, ...}: let
  # Terrain Diffusion MC's CUDA build dlopens libonnxruntime_providers_cuda.so,
  # which needs libcublasLt/libcudnn on LD_LIBRARY_PATH.
  prismlauncher-cuda = pkgs.symlinkJoin {
    name = "prismlauncher-cuda";
    paths = [pkgs.prismlauncher];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/prismlauncher \
        --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [pkgs.cudaPackages.cudatoolkit pkgs.cudaPackages.cudnn]}"
    '';
  };
in {
  home.packages = with pkgs; [
    # -- games
    lutris
    pcsx2

    # -- basic desktop utilities
    freecad
    eog
    gedit
    prismlauncher-cuda
    onlyoffice-desktopeditors
    qbittorrent
    baobab
    inkscape
    rawtherapee
    pinta
    aria2
  ];
}
