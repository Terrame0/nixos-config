{
  lib,
  config-add,
  ...
}:
config-add "list" {
  exclusive-last = list:
    if lib.length list != 1
    then lib.last list
    else null;
}
