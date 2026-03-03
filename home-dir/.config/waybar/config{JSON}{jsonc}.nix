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
    lbracket = span "[";
    rbracket = span "]";
  };
  icon = {
    cpu = color-span palette.aqua "";
    ram = color-span palette.orange "";
    disk = color-span palette.yellow "";
    network = {
      wifi = [
        (color-span palette.green "󰤨")
        (color-span palette.green "󰤥")
        (color-span palette.yellow "󰤢")
        (color-span palette.orange "󰤟")
        (color-span palette.red "󰤯")
      ];
      online = color-span palette.green "";
      offline = color-span palette.red "";
    };
    mic = {
      on = color-span palette.blue "";
      off = color-span palette.comment "";
    };
    volume = {
      levels = [
        (color-span palette.blue "")
        (color-span palette.blue "")
        (color-span palette.blue "")
      ];
      muted = color-span palette.comment "";
    };
    plug = color-span palette.green "";
    batteries = [
      (color-span palette.red "")
      (color-span palette.red "")
      (color-span palette.orange "")
      (color-span palette.yellow "")
      (color-span palette.green "")
    ];
    bars = [
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
  };
in {
  layer = "bottom";
  position = "top";
  height = 42;
  spacing = 0;

  modules-left = [
    "network"
    "custom/clock"
    "pulseaudio"
    "tray"
  ];

  modules-center = [
    "hyprland/workspaces"
  ];

  modules-right = [
    "hyprland/window"
    "cpu"
    "memory"
    "disk"
    "battery"
  ];

  reload_style_on_change = true;

  margin-bottom = 0;
  margin-top = config.style.external-offset;
  margin-left = config.style.external-offset;
  margin-right = config.style.external-offset;

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
    show-passive-items = true;
    icon-size = 20;
    spacing = 7;
    tooltip = false;
  };

  "hyprland/window" = {
    format = "";
    tooltip = false;
  };

  "custom/clock" = {
    exec = "bash ~/.config/waybar/clock.sh";
    interval = 1;
    format = "{}";
    tooltip = false;
  };

  cpu = {
    states = {
      critical = 90;
      alert = 80;
      warning = 70;
      good = 60;
    };
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
    in "{usage}${chr.percent}${chr.lbracket}${bars}${chr.rbracket}${icon.cpu}";
    format-icons = icon.bars;
    interval = 1;
    tooltip = false;
  };

  memory = {
    states = {
      critical = 90;
      alert = 80;
      warning = 70;
      good = 60;
    };
    format = "{used:0.1f}${chr.gb}${chr.slash}{total:0.1f}${chr.gb}${chr.line}${icon.ram}";
    interval = 1;
    tooltip = false;
  };

  battery = {
    states = {
      critical = 20;
      alert = 30;
      warning = 50;
      good = 100;
    };
    interval = 5;
    format = "{capacity}${chr.percent}${chr.line}{icon}";
    format-charging = "{capacity}${chr.percent}${chr.line}${icon.plug}";
    format-icons = icon.batteries;
    tooltip = false;
  };

  disk = {
    states = {
      critical = 90;
      alert = 80;
      warning = 75;
      good = 70;
    };
    interval = 10;
    format = "{specific_free:1.0f}${chr.gb}${chr.slash}{specific_total:1.0f}${chr.gb}${chr.line}${icon.disk}";
    unit = "GB";
    tooltip = false;
  };

  pulseaudio = {
    format = "{volume}${chr.percent}${chr.point}{icon}${chr.point}{format_source}";
    format-muted = "0${chr.percent}${chr.point}${icon.volume.muted}${chr.point}{format_source}";
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
    format-icons = {
      wifi = icon.network.wifi;
    };
    format = "Online${chr.line}${icon.network.online}";
    format-wifi = "Online${chr.line}{icon}";
    format-disconnected = "Offline${chr.line}${icon.network.offline}";
    max-length = 50;
    interval = 5;
    tooltip = false;
  };
}
