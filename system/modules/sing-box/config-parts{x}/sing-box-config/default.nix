args @ {pkgs, ...}:
(pkgs.formats.json {}).generate "sing-box-config.json" (
  (import ./misc.nix args)
  (import ./dns.nix args)
  (import ./inbounds.nix args)
  (import ./outbounds.nix args)
  (import ./route.nix args)
)
