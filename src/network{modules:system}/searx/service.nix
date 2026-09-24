args @ {
  config,
  sundry,
  lib,
  root-vfs,
  ...
}: {
  services.searx = {
    enable = true;
    environmentFile = config.sops.secrets."searx/secret".path;
    redisCreateLocally = true;
    configureUwsgi = false;
    settings = lib.pipe root-vfs.src.network.searx.config [
      (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
      (sundry.vfs.dir.collapse (path: file: file.expr args))
      sundry.attrs.merge.recursive.no-collision
    ];
  };
}
