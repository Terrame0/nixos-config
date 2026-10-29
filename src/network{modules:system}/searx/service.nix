args @ {
  config,
  sundry,
  lib,
  root,
  flake-file-tree,
  ...
}: {
  sing-box.proxied-domains = ["searx.space"];
  services.searx = {
    enable = true;
    environmentFile = config.sops.secrets."searx/secret".path;
    redisCreateLocally = true;
    configureUwsgi = false;
    settings = lib.pipe (sundry.vfs.tree.get-relative-to root ./config flake-file-tree) [
      (sundry.vfs.tree.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
      (sundry.vfs.tree.collapse (path: file: file.expr args))
      sundry.attrs.merge.recursive.no-collision
    ];
  };
}
