# {pkgs, ...}: let
#   pac-file = builtins.path {
#     path = ./pac-config.js;
#   };
# in {
#   systemd.services.pacproxy = {
#     description = "pacproxy (system-wide)";
#     after = ["network.target"];
#     wantedBy = ["multi-user.target"];
#     serviceConfig = {
#       ExecStart = "${pkgs.pacproxy}/bin/pacproxy -c ${pac-file} -l 127.0.0.1:8080";
#       Restart = "always";
#       User = "nobody";
#       Group = "nogroup";
#       UMask = "0077";
#     };
#   };
# }
{...}: {}
