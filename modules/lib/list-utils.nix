{
  lib,
  config-add,
  ...
}:
config-add "lists" {
  exclusive-last = list:
    if lib.length list != 1
    then lib.last list
    else null;

  inclusive-init = list:
    if lib.length list != 1
    then lib.init list
    else list;

  inclusive-tail = list:
    if lib.length list != 1
    then lib.tail list
    else list;
}
