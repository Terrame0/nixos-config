args @ {
  lib,
  sundry,
  ...
}: let
  config-dir = ./${"config{parts}"};
in {
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = lib.pipe config-dir [
    sundry.vfs.dir.from-src
    (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
    (sundry.vfs.dir.collapse (path: file: import file.origin args))
    sundry.attrs.merge.recursive.no-collision
  ];
}
