{...}: let
  terminal = "alacritty";
  file-manager = "dolphin";
  menu = "hyprlauncher";
  super = "SUPER";
in {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      general = {
        layout = "dwindle";
        gaps_in = 5;
        gaps_out = 20;
        border_size = 0;
        resize_on_border = false;
        allow_tearing = false;
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        shadow = {
          enabled = true;
          range = 10;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        blur = {
          enabled = true;
          size = 1;
          passes = 4;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1"
          "quick,0.15,0,0.1,1"
        ];
        animation = [
          "global,1,10,default"
          "border,1,5.39,easeOutQuint"
          "windows,1,4.79,easeOutQuint"
          "windowsIn,1,4.1,easeOutQuint,popin 87%"
          "windowsOut,1,1.49,linear,popin 87%"
          "fadeIn,1,1.73,almostLinear"
          "fadeOut,1,1.46,almostLinear"
          "fade,1,3.03,quick"
          "layers,1,3.81,easeOutQuint"
          "layersIn,1,4,easeOutQuint,fade"
          "layersOut,1,1.5,linear,fade"
          "fadeLayersIn,1,1.79,almostLinear"
          "fadeLayersOut,1,1.39,almostLinear"
          "workspaces,1,1.94,almostLinear,fade"
          "workspacesIn,1,1.21,almostLinear,fade"
          "workspacesOut,1,1.94,almostLinear,fade"
          "zoomFactor,1,7,quick"
        ];
      };

      bind = [
        "${super},q,exec,${terminal}"
        "${super},c,killactive,"
        "${super},m,exec,sh -c 'command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit'"
        "${super},e,exec,${file-manager}"
        "${super},v,togglefloating,"
        "${super},r,exec,${menu}"
        "${super},p,pseudo,"
        "${super},j,togglesplit,"
        "${super},left,movefocus,l"
        "${super},right,movefocus,r"
        "${super},up,movefocus,u"
        "${super},down,movefocus,d"
        "${super},1,workspace,1"
        "${super},2,workspace,2"
        "${super},3,workspace,3"
        "${super},4,workspace,4"
        "${super},5,workspace,5"
        "${super},6,workspace,6"
        "${super},7,workspace,7"
        "${super},8,workspace,8"
        "${super},9,workspace,9"
        "${super},0,workspace,10"
        "${super}+SHIFT,1,movetoworkspace,1"
        "${super}+SHIFT,2,movetoworkspace,2"
        "${super}+SHIFT,3,movetoworkspace,3"
        "${super}+SHIFT,4,movetoworkspace,4"
        "${super}+SHIFT,5,movetoworkspace,5"
        "${super}+SHIFT,6,movetoworkspace,6"
        "${super}+SHIFT,7,movetoworkspace,7"
        "${super}+SHIFT,8,movetoworkspace,8"
        "${super}+SHIFT,9,movetoworkspace,9"
        "${super}+SHIFT,0,movetoworkspace,10"
        "${super},s,togglespecialworkspace,magic"
        "${super}+SHIFT,s,movetoworkspace,special:magic"
        "${super},mouse_down,workspace,e+1"
        "${super},mouse_up,workspace,e-1"
      ];

      bindm = [
        "${super},mouse:272,movewindow"
        "${super},mouse:273,resizewindow"
      ];

      bindel = [
        ",XF86AudioRaiseVolume,exec,wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp,exec,brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown,exec,brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ",XF86AudioNext,exec,playerctl next"
        ",XF86AudioPause,exec,playerctl play-pause"
        ",XF86AudioPlay,exec,playerctl play-pause"
        ",XF86AudioPrev,exec,playerctl previous"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = true;
        };
      };

      gesture = ["3,horizontal,workspace"];

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      windowrule = [
        {
          name = "suppress-maximize-events";
          "match:class" = ".*";
          suppress_event = "maximize";
        }
        {
          name = "fix-xwayland-drags";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = true;
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;
          no_focus = true;
        }
        {
          name = "move-hyprland-run";
          "match:class" = "hyprland-run";
          move = "20 monitor_h-120";
          float = true;
        }
      ];
    };
  };
}
