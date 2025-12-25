{...}:
{  
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