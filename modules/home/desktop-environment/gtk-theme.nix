{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-themes-extra
  ];

  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #   };
  # };

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "brown";
      };
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
# {
#   lib,
#   config,
#   flake-root,
#   ...
# }: {
#   home.file = let
#     file-paths = lib.filesystem.listFilesRecursive (flake-root + "/home-dir");
#     files =
#       lib.filter
#       (file: config.file.get-spec "!" file == null)
#       (lib.forEach file-paths (path: config.store-path.get-file path));
#   in
#     lib.listToAttrs (
#       lib.forEach files
#       (
#         file: let
#           resolved-file = config.convert.home-entry file;
#           file-path = config.file.path-str (resolved-file // {dir = lib.drop 1 resolved-file.dir;});
#         in {
#           name = file-path;
#           value = {
#             source = resolved-file.store-path;
#             executable = true;
#           };
#         }
#       )
#     );
# }

