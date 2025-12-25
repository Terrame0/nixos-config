{pkgs,...}:
{  
  # -- x11 and desktop environment
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };

  users.defaultUserShell = pkgs.zsh;
  
  # -- remove clutter
  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    hitori # sudoku game
    iagno # go game
    tali # poker game
  ]);
}