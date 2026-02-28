{
  lib,
  config-add,
  ...
}:
config-add "list" {
  exclusive-head = list:
    if lib.length list != 1
    then lib.head list
    else null;
}
