{
  lib,
  pkgs,
  ...
}: {
  systemd.services.asusd-enable-fan-curves = {
    description = "Enable asusd fan curves on all profiles";
    wantedBy = ["multi-user.target"];
    after = ["asusd.service"];
    requires = ["asusd.service"];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "enable-fan-curves" ''
        for profile in Quiet Balanced Performance; do
          ${lib.getExe pkgs.asusctl} fan-curve \
            --mod-profile "$profile" \
            --enable-fan-curves true || true
        done
      '';
    };
  };
}
