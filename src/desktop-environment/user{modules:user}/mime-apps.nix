{...}: {
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = ["thunar.desktop"];

      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "text/html" = ["firefox.desktop"];

      "text/plain" = ["org.gnome.gedit.desktop"];

      "image/png" = ["org.gnome.eog.desktop"];
      "image/jpeg" = ["org.gnome.eog.desktop"];
      "image/webp" = ["org.gnome.eog.desktop"];
      "image/gif" = ["org.gnome.eog.desktop"];

      "image/x-xcf" = ["gimp.desktop"];

      "video/mp4" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/x-msvideo" = ["mpv.desktop"];

      "audio/mpeg" = ["mpv.desktop"];
      "audio/flac" = ["mpv.desktop"];
      "audio/ogg" = ["mpv.desktop"];

      "application/pdf" = ["onlyoffice-desktopeditors.desktop"];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [
        "onlyoffice-desktopeditors.desktop"
      ];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = [
        "onlyoffice-desktopeditors.desktop"
      ];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = [
        "onlyoffice-desktopeditors.desktop"
      ];

      "application/x-bittorrent" = ["qbittorrent.desktop"];

      "application/zip" = ["org.gnome.FileRoller.desktop"];
      "application/x-tar" = ["org.gnome.FileRoller.desktop"];
      "application/x-xz" = ["org.gnome.FileRoller.desktop"];
      "application/x-7z-compressed" = ["org.gnome.FileRoller.desktop"];
      "application/x-rar" = ["org.gnome.FileRoller.desktop"];
    };
  };
}
