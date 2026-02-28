{
  config-add,
  lib,
  config,
  ...
}:
config-add "make-span" (
  parameters: string: let
    parameter-list = lib.mapAttrsToList (name: value: "${name}='${value}'") parameters;
    parameter-string = lib.concatStringsSep " " parameter-list;
  in
    config.debug "<span ${parameter-string}>${string}</span>"
)
