args @ {
  pkgs,
  lib,
  sundry,
  ...
}:
lib.pipe [
  ./misc.nix
  ./dns.nix
  ./inbounds.nix
  ./outbounds.nix
  ./route.nix
] [
  (map (path: import path args))
  sundry.attrs.merge.no-collision
  ((pkgs.formats.json {}).generate "sing-box-config.json")
]
