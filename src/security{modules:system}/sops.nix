{
  lib,
  sundry,
  username,
  pkgs,
  ...
}: let
  secrets-src = ./secrets;
  age-key-src = "/etc/sops/age/master.txt";
in {
  environment.systemPackages = with pkgs; [
    sops
    age
  ];
  environment.variables = {
    SOPS_AGE_KEY_FILE = age-key-src;
    # -- to not enter the key fingerprint manually when using sops cli
    SOPS_AGE_RECIPIENTS = "age1rh3ejm93aaawujhuhst4tezwneefkxhh0aede0wpqf86mpjhesks6rem3m";
  };
  sops = {
    age.keyFile = age-key-src;
    secrets = lib.pipe secrets-src [
      sundry.vfs.dir.from-src
      sundry.vfs.dir.resolve-tags
      (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "yaml"))
      (sundry.vfs.dir.collapse (
        path: file:
          lib.pipe file.text [
            (lib.splitString "\n")
            (lib.filter
              (line:
                builtins.match "[A-Za-z0-9_/-]+:.*" line != null && line != ""))
            (map (sundry.str.before ":"))
            (lib.filter (key: key != "sops"))
            (map (key: {
              "${sundry.vfs.path.get.stem path}/${key}" = {
                sopsFile = file.origin;
                neededForUsers = (sundry.attrs.merge.no-collision file.tag-list) ? "for-users";
                inherit key;
                owner = username;
                mode = "0400";
              };
            }))
            sundry.attrs.merge.recursive.no-collision
          ]
      ))
      sundry.attrs.merge.recursive.no-collision
    ];
  };
}
