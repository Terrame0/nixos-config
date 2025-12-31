{...}: {
  nixpkgs.overlays = [
    (self: super: {
      transmission_4-gtk = super.transmission_4-gtk.overrideAttrs (oldAttrs: {
        nativeBuildInputs =
          (oldAttrs.nativeBuildInputs or []) ++ [super.makeWrapper];
        postInstall =
          (oldAttrs.postInstall or "")
          + ''
            for bin in transmission-gtk transmission-qt; do
              if [ -x "$out/bin/$bin" ]; then
                wrapProgram "$out/bin/$bin" \
                  --set GTK_THEME Adwaita:dark
              fi
            done
          '';
      });
    })
  ];
}
