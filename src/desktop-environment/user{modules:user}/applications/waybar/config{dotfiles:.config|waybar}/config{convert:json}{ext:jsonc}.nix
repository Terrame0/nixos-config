{
  lib,
  host,
  ...
}: let
  palette = {
    black = "#1d1f21";
    dark-gray = "#282a2e";
    dim-gray = "#373b41";
    gray = "#4d5057";
    light-gray = "#969896";
    white = "#c5c8c6";
    red = "#d54e53";
    orange = "#e78c45";
    yellow = "#e7c547";
    green = "#b9ca4a";
    aqua = "#70c0b1";
    blue = "#7aa6da";
    purple = "#c397d8";
  };
  make-span = parameters: string: let
    parameter-list = lib.mapAttrsToList (name: value: "${name}='${value}'") parameters;
    parameter-string = lib.concatStrings parameter-list;
  in "<span ${parameter-string}>${string}</span>";
  color-span = color: make-span {inherit color;};
  chr = let
    span = color-span palette.light-gray;
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
      connected = color-span palette.green "";
      disconnected = color-span palette.light-gray "";
    };
    mic = {
      on = color-span palette.blue "";
      off = color-span palette.light-gray "";
    };
    volume = {
      levels = [
        (color-span palette.blue "")
        (color-span palette.blue "")
        (color-span palette.blue "")
      ];
      muted = color-span palette.light-gray "";
    };
    batteries = {
      critical = color-span palette.red "";
      alert = color-span palette.orange "";
      warning = color-span palette.yellow "";
      good = color-span palette.green "";
      full = color-span palette.green "";
    };
    bars = [
      (color-span palette.light-gray "▁")
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
in
  {
    layer = "bottom";
    position = "top";
    spacing = 0;

    modules-left = [
      "custom/clock"
      "custom/spacer-1"
      "pulseaudio"
      "custom/spacer-2"
      "battery"
      "network"
    ];

    modules-center = [
      "hyprland/workspaces"
    ];

    modules-right = [
      "tray"
      "hyprland/window"
      "cpu"
      "custom/spacer-3"
      "memory"
      "custom/spacer-4"
      "disk"
    ];

    reload_style_on_change = true;

    margin-bottom = 0;
    margin-top = 6;
    margin-left = 6;
    margin-right = 6;
    height = 44;

    # --- MODULES LEFT ---

    network = {
      format-icons = {
        wifi = icon.network.wifi;
      };
      format = "Connected${chr.point}${icon.network.connected}";
      format-wifi = "Connected${chr.point}{icon}";
      format-disconnected = "Disconnected${chr.point}${icon.network.disconnected}";
      interval = 1;
      tooltip = false;
    };

    battery = {
      states = {
        critical = 10;
        alert = 30;
        warning = 60;
        good = 95;
        full = 100;
      };
      interval = 1;
      format = "{capacity}${chr.percent}${chr.point}{icon}";
      format-charging = "{capacity}${chr.percent}${chr.point}";
      format-icons = icon.batteries;
      tooltip = false;
    };

    tray = {
      show-passive-items = true;
      icon-size = 20;
      spacing = 7;
      tooltip = false;
    };
  }
  // lib.foldl (
    spacers: i:
      spacers
      // {
        "custom/spacer-${toString i}" = {
          format = chr.line;
          tooltip = false;
        };
      }
  ) {} (lib.genList (i: i + 1) 4)
  // {
    "custom/clock" = {
      exec = "bash ~/.config/waybar/clock.sh";
      interval = 1;
      format = "{}";
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

    # --- MODULES CENTER ---

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

    # --- MODULES RIGHT ---

    "hyprland/window" = {
      format = "";
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
          make-span {
            size = "9pt";
            rise = "2.25pt";
          }
          (
            lib.concatStrings (
              lib.forEach (
                builtins.genList (i: i) host.cores
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
      format = "{used:0.1f}${chr.gb}${chr.slash}{total:0.1f}${chr.gb}${chr.point}${icon.ram}";
      interval = 1;
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
      format = "{specific_free:1.0f}${chr.gb}${chr.slash}{specific_total:1.0f}${chr.gb}${chr.point}${icon.disk}";
      unit = "GB";
      tooltip = false;
    };
  }
