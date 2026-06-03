{...}: {
  programs.zsh.profileExtra = ''
    if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec uwsm start -e -D Hyprland hyprland-uwsm.desktop
    fi
  '';
}
