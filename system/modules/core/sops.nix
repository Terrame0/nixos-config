{
  lib,
  mlem,
  config-root,
  username,
  pkgs,
  ...
}: let
  secrets-src = "${config-root}/system/secrets";
  age-key-src = "/home/${username}/age/keys.txt";
in {
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  environment.variables = {
    SOPS_AGE_KEY_FILE = age-key-src;
    SOPS_AGE_RECIPIENTS = "age1rh3ejm93aaawujhuhst4tezwneefkxhh0aede0wpqf86mpjhesks6rem3m";
  };
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
            (map (key: {
              "${mlem.vfs.path.get.stem path}/${key}" = {
                neededForUsers = true;
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
