{
  lib,
  extend-config,
  ...
}:
extend-config "list" {
  inclusive-init = list:
    if lib.length list != 1
    then lib.init list
    else list;
}
