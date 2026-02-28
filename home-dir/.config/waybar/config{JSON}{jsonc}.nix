{config, ...}: let
  palette = config.palette;
  make-span = config.make-span;
  chr = let
    span = make-span palette.comment;
  in {
    line = span "|";
    interpoint = span "·";
    triple-equal-sign = span "===";
    percent = span " 󰏰";
    gb = span "G";
    slash = span "/";
  };
  icon = {
    cpu = make-span palette.aqua "";
    ram = make-span palette.orange "";
    disk = make-span palette.yellow "";
    network = {
      online = make-span palette.green "";
      offline = make-span palette.red "";
    };
    mic = {
      on = make-span palette.purple "";
      off = make-span palette.comment "";
    };
    volume = {
      off = make-span palette.purple "";
      low = make-span palette.purple "";
      high = make-span palette.purple "";
      muted = make-span palette.comment "";
    };
    battery = [
      make-span
      palette.red
      ""
      make-span
      palette.red
      ""
      make-span
      palette.orange
      ""
      make-span
      palette.yellow
      ""
      make-span
      palette.green
      ""
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
    format = "{usage}${chr.percent}${chr.line}${icon.cpu}";
    interval = 1;
    tooltip = false;
  };

  memory = {
    format = "{used:0.1f}G/{total:0.1f}G|${make-span palette.orange ""}";
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
    format = "{icon}{capacity}%";
    format-charging = " {icon} {capacity}%";
    format-icons = icon.battery;
    tooltip = false;
  };

  disk = {
    interval = 30;
    format = "{specific_free:1.0f}G/{specific_total:1.0f}G|";
    unit = "GB";
    tooltip = false;
  };

  pulseaudio = {
    format = "{volume}%·{icon}|{format_source}";
    format-muted = "0%·|{format_source}";
    format-icons = {
      default = ["" ""];
    };
    format-source = "";
    format-source-muted = "";
    scroll-step = 10;
    tooltip = false;
    on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
  };

  network = {
    format = "Online|";
    format-disconnected = "Disconnected|";
    tooltip = false;
  };
}
