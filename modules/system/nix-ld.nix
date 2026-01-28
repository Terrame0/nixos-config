{ pkgs, ... }:

let
  pkgs32 = pkgs.pkgs32;
in {
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

      # -- x11 / graphics stack
      xorg.libX11
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libXfixes
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXxf86vm
      xorg.libXinerama
      xorg.libXcursor
      xorg.libXrender
      xorg.libXScrnSaver
      xorg.libXi
      xorg.libSM
      xorg.libICE
      xorg.libXt
      xorg.libXmu
      xorg.libXft

      libxcb

      # -- opengl / mesa
      libGL
      libGLU
      libgbm
      libdrm
      libvdpau
      libva
      libelf
      glew110
      freeglut

      # -- gtk / glib
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

      # -- sdl
      SDL
      SDL2
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_image
      SDL2_ttf
      SDL2_mixer

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

      # -- vulkan
      vulkan-loader

      # -- indicators / legacy gtk
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

      # -- appimage support
      fuse
      e2fsprogs

      # -- 32-bit graphics (via pkgs32)
      pkgs32.libGL
      pkgs32.libGLU
      pkgs32.mesa
      pkgs32.vulkan-loader

      # -- 32-bit audio (via pkgs32)
      pkgs32.alsa-lib
      pkgs32.pulseaudio
      pkgs32.SDL2
      pkgs32.SDL2_mixer

      # -- fonts
      fonts.fontconfig
      corefonts

      # -- optional xcb extensions
      libxcb-util
      libxcb-render-util
      libxcb-image

      # -- terminal / misc (32-bit)
      pkgs32.ncurses
    ];
  };
}
