{
  lib,
  pkgs,
  sundry,
  ...
}: let
  # -- TODO rewrite this
  asusctl = lib.getExe pkgs.asusctl;
  curves = {
    performance = [
      [25 102]
      [40 153]
      [45 204]
      [50 230]
      [55 255]
      [70 255]
      [75 255]
      [80 255]
    ];
    balanced = [
      [30 77]
      [45 128]
      [55 179]
      [65 217]
      [70 255]
      [75 255]
      [80 255]
      [85 255]
    ];
    quiet = [
      [35 51]
      [50 102]
      [60 153]
      [70 204]
      [75 230]
      [80 255]
      [85 255]
      [90 255]
    ];
  };
  fans = ["cpu" "gpu"];
  pointToStr = p: "${toString (sundry.list.at 0 p)}c:${toString (sundry.list.at 1 p)}";
  curveToData = points: lib.concatMapStringsSep "," pointToStr points;
  profiles = lib.attrNames curves;
  set-cmds = map (
    pair: let
      profile = sundry.list.at 0 pair;
      fan = sundry.list.at 1 pair;
    in ''${asusctl} fan-curve --mod-profile ${profile} --fan ${fan} --data "${curveToData curves.${profile}}"''
  ) (sundry.list.product profiles fans);
  enable-cmds =
    map (profile: "${asusctl} fan-curve --mod-profile ${profile} --enable-fan-curves true") profiles;
in {
  systemd.services.asusd-apply-fan-curves = {
    description = "Apply and enable asusd fan curves on all profiles";
    wantedBy = ["multi-user.target"];
    after = ["asusd.service"];
    requires = ["asusd.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "apply-fan-curves" ''
        for _ in $(seq 1 10); do
          ${asusctl} fan-curve --get-enabled >/dev/null 2>&1 && break
          sleep 1
        done
        ${lib.concatStringsSep "\n" (set-cmds ++ enable-cmds)}
      '';
    };
  };
}
# {
#   lib,
#   pkgs,
#   sundry,
#   ...
# }: let
#   asusctl = lib.getExe' pkgs.asusctl "asusctl";
#   curves = {
#     performance = [
#       [25 40 45 50 55 70 75 80]
#       [102 153 204 230 255 255 255 255]
#     ];
#     balanced = [
#       [30 45 55 65 70 75 80 85]
#       [77 128 179 217 255 255 255 255]
#     ];
#     quiet = [
#       [35 50 60 70 75 80 85 90]
#       [51 102 153 204 230 255 255 255]
#     ];
#   };
#   cmds = lib.pipe curves [
#     (sundry.attrs.collapse
#       (path: curve:
#         (lib.concatMapStrings (fan: let
#           data = lib.pipe curve [
#             sundry.list.zip
#             (lib.concatMapStringsSep ","
#               (point: "${toString (sundry.list.at 0 point)}c:${toString (sundry.list.at 1 point)}"))
#           ];
#         in "${asusctl} fan-curve --mod-profile '${sundry.list.at 0 path}' --fan '${fan}' --data '${data}'\n") ["cpu" "gpu"])
#         + "${asusctl} fan-curve --mod-profile '${sundry.list.at 0 path}' --enable-fan-curves true\n"))
#     lib.concatStrings
#   ];
# in {
#   systemd.services.asusd-apply-fan-curves = {
#     description = "a oneshot service that applies fan curves";
#     wantedBy = ["multi-user.target"];
#     after = ["asusd.service"];
#     requires = ["asusd.service"];
#     serviceConfig = {
#       Type = "oneshot";
#       RemainAfterExit = true;
#       ExecStart = pkgs.writeShellScript "apply-fan-curves" (sundry.debug ''
#         for _ in $(seq 1 10); do
#           ${asusctl} fan-curve --get-enabled >/dev/null 2>&1 && break
#           sleep 1
#         done
#         ${cmds}
#       '');
#     };
#   };
# }

