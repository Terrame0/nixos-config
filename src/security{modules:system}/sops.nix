{
  lib,
  sundry,
  host,
  pkgs,
  inputs,
  root,
  flake-file-tree,
  ...
}: let
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
  imports = [inputs.sops-nix.nixosModules.sops];
  sops = {
    age.keyFile = age-key-src;
    secrets = lib.pipe (sundry.vfs.dir.get-relative-to root ./secrets flake-file-tree) [
      (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "yaml"))
      (sundry.vfs.dir.collapse (
        path: file:
        # -- preferrably replace this with a yaml parser
          lib.pipe file.text [
            (lib.splitString "\n")
            (map (sundry.str.before ":"))
            (lib.filter (key:
              (builtins.match "[A-Za-z0-9_/-]+" key != null)
              && key != ""
              && key != "sops"))
            (map (key: let
              sanitized-path = sundry.vfs.path.set.ext "" path;
              path-str = sundry.vfs.path.get.str sanitized-path;
            in {
              "${path-str}/${key}" = {
                # -- store coercion breaks further down the line 
                # - on a tagged path so we force the coercion here
                sopsFile = sundry.path.to-store file.origin;
                neededForUsers = (sundry.attrs.merge.no-collision file.tag-list) ? "for-users";
                inherit key;
                owner = host.username;
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
