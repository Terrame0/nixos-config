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
        text =
          # -< nushell >-
          ''
            for card in (glob /sys/class/sound/card[0-9]* | sort) {
              let id_file = $"($card)/id"
              if not ($id_file | path exists) { continue }
              if (open $id_file | str trim) != "Headset" { continue }
              let n = ($card | path basename | str replace "card" "")
              for _ in 1..5 {
                let probe = (^amixer -c $n sset "G435 Wireless Gaming Headset Playback Switc" on | complete)
                if $probe.exit_code == 0 {
                  ^amixer -c $n sset "G435 Wireless Gaming Headset Playback Volum" "100%" unmute | complete | ignore
                  break
                }
                sleep 1sec
              }
            }
          '';
      });
    };
  };
}
