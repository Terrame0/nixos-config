{...}: {
  programs.waybar = {
    enable = true;
    style = ./configurations/waybar.css;
    settings = {
      mainBar = {
        "gtk-layer-shell" = true;
        "icon-theme" = "Adwaita"; # ← Change this to your installed icon theme name
        "icon-size" = 16;
        layer = "top";
        position = "top";
        "modules-left" = ["clock" "wlr/taskbar"];
        "modules-center" = ["hyprland/workspaces"];
        "modules-right" = ["cpu" "memory" "disk" "network" "pulseaudio" "tray" "group/group-power"];

        "wlr/taskbar" = {
          format = "{icon}";
          tooltip = true;
          "tooltip-format" = "{title}";
          "on-click" = "activate";
          "on-click-middle" = "close";
          "active-first" = false;
        };

        "hyprland/workspaces" = {
          format = "{icon}";
          "persistent-workspaces" = {
            "DP-1" = [1 2 3 4 5 6 7 8 9 10];
          };
        };

        clock = {
          format = "{:%I:%M %p}";
          rotate = 0;
          "format-alt" = "{:%A, %B %d, %Y (%R)}";
          "tooltip-format" = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            format = {
              months = "<span color='#aecce6'><b>{}</b></span>";
              days = "<span color='#aecce6'><b>{}</b></span>";
              weekdays = "<span color='#df373a'><b>{}</b></span>";
              today = "<span color='#df373a'><b>{}</b></span>";
            };
          };
        };

        cpu = {
          format = "⧯ Cpu: {usage}%";
          tooltip = true;
        };

        network = {
          tooltip = true;
          rotate = 0;
          "format-ethernet" = "<span foreground='#242639'> {bandwidthDownBytes}</span>";
          "format-linked" = "{ifname} (No IP)";
          "format-disconnected" = "";
          "tooltip-format-disconnected" = "Disconnected";
          "format-alt" = " Up: {bandwidthUpBytes}";
          interval = 2;
        };

        tray = {
          "icon-size" = 21;
          spacing = 10;
        };

        pulseaudio = {
          format = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-muted" = "";
          "format-icons" = {
            "alsa_output.pci-0000_00_1f.3.analog-stereo" = "";
            "alsa_output.pci-0000_00_1f.3.analog-stereo-muted" = "";
            headphone = "";
            "hands-free" = "";
            headset = "";
            phone = "";
            "phone-muted" = "";
            portable = "";
            car = "";
            default = ["" ""];
          };
          "scroll-step" = 3;
          "on-click" = "pavucontrol";
          "ignored-sinks" = ["Easy Effects Sink"];
        };

        memory = {
          interval = 5;
          format = "󰍛  Mem: {}%";
          "max-length" = 15;
        };

        "group/group-power" = {
          orientation = "horizontal";
          drawer = {
            "transition-duration" = 500;
            "children-class" = "not-power";
            "transition-left-to-right" = false;
          };
          modules = [
            "user"
            "custom/shutdown"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
          ];
        };

        "custom/quit" = {
          format = "󰗼";
          "tooltip-format" = "Exit";
          "on-click" = "hyprctl dispatch exit";
        };

        "custom/lock" = {
          format = "󰍁";
          "tooltip-format" = "Lock";
          "on-click" = "hyprlock";
        };

        "custom/reboot" = {
          format = "󰜉";
          "tooltip-format" = "Reboot";
          "on-click" = "reboot";
        };

        "custom/shutdown" = {
          format = "⏻";
          "tooltip-format" = "Shutdown";
          "on-click" = "shutdown now";
        };

        disk = {
          interval = 30;
          format = " {used}";
          unit = "GB";
          "tooltip-format" = " {percentage_used}%";
        };

        user = {
          format = "{user}";
          height = 20;
          width = 20;
          icon = true;
        };
      };
    };
  };
}
