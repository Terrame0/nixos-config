args @ {pkgs, ...}: let
  part = name: import (./. + "/${name}.nix") args;
in
  (pkgs.formats.json {}).generate "sing-box-config.json" (
    (part "misc")
    // (part "dns")
    // (part "inbounds")
    // (part "outbounds")
    // (part "route")
  )
