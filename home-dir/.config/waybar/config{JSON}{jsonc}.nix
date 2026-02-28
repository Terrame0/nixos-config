{
  config,
  lib,
  ...
}: let
  palette = config.palette;
  color-span = color: config.make-span {inherit color;};
  chr = let
    span = color-span palette.comment;
  in {
    line = span "|";
    point = span "·";
    triple-equal-sign = span "===";
    percent = span "󰏰";
    gb = span "G";
    slash = span "/";
  };
  icon = {
    cpu = color-span palette.aqua "";
    ram = color-span palette.orange "";
    disk = color-span palette.yellow "";
    network = {
      online = color-span palette.green "";
      offline = color-span palette.red "";
    };
    mic = {
      on = color-span palette.purple "";
      off = color-span palette.comment "";
    };
    volume = {
      levels = let
        span = color-span palette.purple;
      in [
        (span "")
        (span "")
        (span "")
      ];
      muted = color-span palette.comment "";
    };
    batteries = [
      (color-span palette.red "")
      (color-span palette.red "")
      (color-span palette.orange "")
      (color-span palette.yellow "")
      (color-span palette.green "")
    ];
  };
in {
  layer = "bottom";
  position = "top";
  height = 40;
  spacing = 0;

  modules-left = [
    "network"
    "custom/clock"
    "pulseaudio"
  ];

  modules-center = [
    "hyprland/workspaces"
  ];

  modules-right = [
    "tray"
    "cpu"
    "memory"
    "disk"
    "battery"
  ];

  reload_style_on_change = true;

  margin-bottom = 0;
  margin-top = 6;
  margin-left = 6;
  margin-right = 6;

  "hyprland/workspaces" = {
    disable-scroll = false;
    all-outputs = true;
    warp-on-scroll = false;
    format = "{name}";
    persistent-workspaces = {
      "*" = 5;
    };
    tooltip = false;
  };

  tray = {
    icon-size = 20;
    spacing = 7;
    tooltip = false;
  };

  "custom/clock" = {
    exec = "bash ~/.config/waybar/clock.sh";
    interval = 1;
    format = "{}";
    tooltip = false;
  };

  cpu = {
    format = let
      bars =
        config.make-span {
          size = "9pt";
          rise = "2.25pt";
        }
        (
          lib.concatStringsSep "" (
            lib.forEach (
              builtins.genList (i: i) (builtins.fromJSON (config.run-command "nproc"))
            )
            (
              id: "{icon${toString id}}"
            )
          )
        );
    in "{usage}${chr.percent}${chr.line}${bars}${chr.line}${icon.cpu}";
    format-icons = [
      (color-span palette.comment "▁")
      (color-span palette.blue "▁")
      (color-span palette.aqua "▂")
      (color-span palette.aqua "▃")
      (color-span palette.green "▄")
      (color-span palette.yellow "▅")
      (color-span palette.orange "▆")
      (color-span palette.red "▇")
      (color-span palette.red "█")
    ];
    interval = 1;
    tooltip = false;
  };

  memory = {
    format = "{used:0.1f}${chr.gb}${chr.slash}{total:0.1f}${chr.gb}${chr.line}${icon.ram}";
    interval = 1;
    tooltip = false;
  };

  battery = {
    states = {
      good = 100;
      warning = 70;
      critical = 20;
    };
    interval = 5;
    format = "{icon}{capacity}${chr.percent}";
    format-charging = " {icon} {capacity}${chr.percent}";
    format-icons = icon.batteries;
    tooltip = false;
  };

  disk = {
    interval = 30;
    format = "{specific_free:1.0f}${chr.gb}${chr.slash}{specific_total:1.0f}${chr.gb}${chr.line}${icon.disk}";
    unit = "GB";
    tooltip = false;
  };

  pulseaudio = {
    format = "{volume}${chr.percent}${chr.point}{icon}${chr.line}{format_source}";
    format-muted = "0${chr.percent}${chr.point}${icon.volume.muted}|{format_source}";
    format-icons = {
      default = icon.volume.levels;
    };
    format-source = icon.mic.on;
    format-source-muted = icon.mic.off;
    scroll-step = 10;
    tooltip = false;
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  };

  network = {
    format = "Online${chr.line}${icon.network.online}";
    format-disconnected = "Offline${chr.line}${icon.network.offline}";
    tooltip = false;
  };
}
