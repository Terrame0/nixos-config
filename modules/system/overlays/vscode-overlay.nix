{...}: let
  overlay = final: prev: {
    vscode = prev.vscode.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ final.makeWrapper ];

      postInstall = (old.postInstall or "") + ''
        wrapProgram "$out/bin/code" \
          --set ELECTRON_OZONE_PLATFORM_HINT "x11" \
          --add-flags '--enable-transparent-visuals --ozone-platform=x11'
      '';
    });
  };
in {
  nixpkgs.overlays = [ overlay ];
}