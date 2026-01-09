{pkgs, ...}: {
  # -- gnome extensions
  home.packages = with pkgs; [
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-history
    gnomeExtensions.clipboard-history
  ];
}
