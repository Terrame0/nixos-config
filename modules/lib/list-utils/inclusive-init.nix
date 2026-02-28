{
  lib,
  config-add,
  ...
}:
config-add "list" {
  inclusive-init = list:
    if lib.length list != 1
    then lib.init list
    else list;
}
