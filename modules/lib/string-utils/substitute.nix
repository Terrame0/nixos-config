{
  lib,
  config-add,
  config,
  ...
}:
config-add "string" {
  substitute = string: let
    bruh = config.string.between "\"@[" "]\"" string;
  in
    0;
}
