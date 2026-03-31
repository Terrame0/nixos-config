{pkgs, ...}: {
  # -- nix-ld (run unpatched binaries)
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      # -- default libraries
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      xz
      systemd

      # -- X11 / graphics stack
      libX11
      libXcomposite
      libXtst
      libXrandr
      libXext
      libXfixes
      libXdamage
      libxshmfence
      libXxf86vm
      libXinerama
      libXcursor
      libXrender
      libXScrnSaver
      libXi
      libSM
      libICE
      libXt
      libXmu
      libXft

      libxcb

      # -- OpenGL / Mesa
      libGL
      libGLU
      libgbm
      libdrm
      libvdpau
      libva
      libelf
      glew110
      freeglut

      # -- GTK / GLib
      glib
      gtk2
      gtk3
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype
      gsettings-desktop-schemas
      libnotify
      librsvg
      gnome2.GConf

      # -- audio / video
      pipewire
      alsa-lib
      ffmpeg
      flac
      libogg
      libvorbis
      libtheora
      libvpx
      libsamplerate
      speex

      # -- SDL
      SDL2
      SDL2_image
      SDL2_ttf
      SDL2_mixer

      SDL
      SDL_image
      SDL_ttf
      SDL_mixer

      # -- system / runtime
      coreutils
      pciutils
      util-linux
      dbus
      dbus-glib
      expat
      icu
      cups
      libcap
      libusb1
      nspr
      nss
      networkmanager
      zenity

      # -- Vulkan
      vulkan-loader

      # -- indicators / legacy GTK
      libappindicator-gtk2
      libdbusmenu-gtk2
      libindicator-gtk2
      libcanberra
      libcaca
      libgcrypt

      # -- image formats
      libjpeg
      libpng
      libpng12
      libtiff
      pixman

      # -- misc
      libidn
      tbb
      libmikmod
      libudev0-shim
      libxkbcommon

      # -- legacy / compatibility
      libxcrypt
      libxcrypt-legacy

      # -- AppImage support
      fuse
      e2fsprogs
    ];
  };
}
