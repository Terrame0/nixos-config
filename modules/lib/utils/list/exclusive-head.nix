{
  lib,
  extend-config,
  ...
}:
extend-config "list" {
  exclusive-head = list:
    if lib.length list != 1
    then lib.head list
    else null;
}
