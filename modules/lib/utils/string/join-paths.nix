{
  lib,
  extend-config,
  ...
}:
extend-config "string" {
  join-paths = paths:
    lib.foldl (
      path-acc: path: "${lib.removeSuffix "/" path-acc}/${lib.removePrefix "/" path}"
    ) ""
    paths;
}
