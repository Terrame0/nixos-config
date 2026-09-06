args' @ {
  config,
  sundry,
  lib,
  ...
}: let
  args = args' // {inherit config-dir;};
  config-dir = ./${"config{parts}"};
in {
  services.searx = {
    enable = true;
    environmentFile = config.sops.secrets."searx/secret".path;
    redisCreateLocally = true;
    configureUwsgi = false;
    settings = lib.pipe config-dir [
      sundry.vfs.dir.from-src
      sundry.vfs.dir.load-nix
      (sundry.vfs.dir.collapse (path: file: file.expr args))
      sundry.attrs.merge.recursive.no-collision
      sundry.debug
    ];
  };
}
