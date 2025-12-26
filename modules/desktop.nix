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

  # -- touchpad support
  services.libinput.enable = true;

  # -- remove clutter
  environment.gnome.excludePackages = (with pkgs; [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    hitori # sudoku game
    iagno # go game
    tali # poker game
  ]);

  # -- totem fix (to use OpenGL ES)
  environment.variables = {
    GDK_GL = "gles";
  };

  # -- auto-login
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "terrame";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}