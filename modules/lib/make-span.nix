{
  extend-config,
  lib,
  ...
}:
extend-config "make-span" (
  parameters: string: let
    parameter-list = lib.mapAttrsToList (name: value: "${name}='${value}'") parameters;
    parameter-string = lib.concatStrings parameter-list;
  in "<span ${parameter-string}>${string}</span>"
)
