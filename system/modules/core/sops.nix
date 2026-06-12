{
  lib,
  mlem,
  flake-root,
  username,
  pkgs,
  ...
}: let
  secrets-src = "${flake-root}/secrets";
  age-key-src = "/home/${username}/age/keys.txt";
in {
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  environment.variables.SOPS_AGE_KEY_FILE = age-key-src;
  sops = {
    age.keyFile = age-key-src;
    secrets = lib.pipe secrets-src [
      mlem.vfs.dir.from-src
      (mlem.vfs.dir.filter (path: file: mlem.vfs.path.get.ext path == "yaml"))
      (mlem.vfs.dir.collapse (
        path: file:
          lib.pipe file.contents [
            (lib.splitString "\n")
            (lib.filter
              (line:
                builtins.match "[A-Za-z0-9_/-]+:.*" line != null && line != ""))
            (map (mlem.string.before ":"))
            (lib.filter (key: key != "sops"))
            (map (key: let
              attrname = "${mlem.vfs.path.get.stem path}/${key}";
            in {
              ${attrname} = {
                sopsFile = mlem.vfs.path.get.str ([secrets-src] ++ path);
                inherit key;
                owner = username;
                mode = "0400";
              };
            }))
            mlem.attrs.merge.recursive.no-collision
          ]
      ))
      mlem.attrs.merge.recursive.no-collision
    ];
  };
}
