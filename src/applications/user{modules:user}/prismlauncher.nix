{pkgs, ...}: let
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
  home.packages = [prismlauncher-cuda];
}
