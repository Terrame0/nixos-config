{
  lib,
  extend-config,
  ...
}:
extend-config "list" {
  inclusive-tail = list:
    if lib.length list != 1
    then lib.tail list
    else list;
}
