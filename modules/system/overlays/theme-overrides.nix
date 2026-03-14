{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      thunar = prev.thunar.overrideAttrs (old: {
        postInstall =
          (old.postInstall or "")
          + "wrapProgram $out/bin/thunar --set GTK_THEME my-theme";
      });
    })
  ];
}
