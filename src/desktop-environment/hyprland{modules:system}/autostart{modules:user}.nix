{...}: {
  programs.zsh.loginExtra =
    /*
    bash
    */
    ''
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
}
