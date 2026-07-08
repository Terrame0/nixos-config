{pkgs, ...}: {
  home.packages = [
    (pkgs.symlinkJoin {
      name = "lutris";
      paths = [ pkgs.lutris ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/lutris \
          --unset GIO_EXTRA_MODULES \
          --unset GIO_MODULE_DIR
      '';
    })
  ];
}
