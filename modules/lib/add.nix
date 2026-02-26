# -- this is the most beautiful 
# piece code i have ever writen :)
{lib, ...}: let
  add = namespace: args: {
    options.${namespace} = lib.mkOption {
      type = lib.types.anything;
      description = namespace;
    };
    config.${namespace} = args;
  };
in
  add "add" add
