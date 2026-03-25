{
  extend-config,
  lib,
  ...
}:
extend-config "list" {
  indexed-foldl = f: init: list:
    lib.foldl (
      acc: i:
        f acc (lib.elemAt list i) i
    )
    init
    (lib.genList (i: i) (lib.length list));
}
