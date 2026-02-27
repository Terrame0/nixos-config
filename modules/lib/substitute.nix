{
  lib,
  config-add,
  config,
  ...
}:
config-add "strings" {
  substitute = string: let
    bruh = config.strings.between "\"@[" "]\"" string;
  in
    0;
}
