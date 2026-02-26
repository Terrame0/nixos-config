{lib, ...}: {
  _module.args = {
    config-add = namespace: args: {
      options.${namespace} = lib.mkOption {
        type = lib.types.anything;
        description = namespace;
      };
      config.${namespace} = args;
    };
  };

  imports = lib.filter (path: lib.hasSuffix ".nix" (toString path)) (
    (lib.filesystem.listFilesRecursive ../../modules/system)
    ++ (lib.filesystem.listFilesRecursive ../../modules/lib)
  );

  # -- system state version
  system.stateVersion = "25.11";

  # -- hostname
  networking.hostName = "desktop";
}
