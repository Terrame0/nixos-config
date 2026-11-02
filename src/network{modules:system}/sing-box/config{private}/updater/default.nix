{
  pkgs,
  paths,
  skeleton,
  sundry,
  ...
}:
pkgs.writeShellApplication {
  name = "sing-box-updater";
  runtimeInputs = [pkgs.curl pkgs.jq pkgs.sing-box pkgs.coreutils];
  runtimeEnv = {
    SKELETON = skeleton;
    NODE_FILTER = sundry.path.to-store-sanitize ./node-filter.jq;
    RESPONSE_FILE = paths.response-file;
    STORED_CONFIG = paths.stored-config;
    RUNTIME_CONFIG = paths.runtime-config;
  };
  text = builtins.readFile ./update.sh;
}
