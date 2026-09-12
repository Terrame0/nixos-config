{
  pkgs,
  lib,
  ...
}: {
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="sound", KERNEL=="card*", ATTR{id}=="Headset", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="0acb", TAG+="systemd", ENV{SYSTEMD_WANTS}+="g435-hw-volume.service"
  '';
  systemd.services.g435-hw-volume = {
    description = "Force G435 USB dongle hardware playback volume to 100%";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.getExe (pkgs.nuenv.writeShellApplication {
        name = "g435-hw-volume";
        runtimeInputs = [pkgs.alsa-utils];
        text = builtins.readFile ./g435-fix.nu;
      });
    };
  };
}
