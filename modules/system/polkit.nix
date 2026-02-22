{pkgs, ...}: {
  security.polkit.enable = true;
  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];
  systemd.user.services.polkit-agent = {
    description = "Polkit Authentication Agent";
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "always";
    };
  };
}
