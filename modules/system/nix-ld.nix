{pkgs, ...}: let
  # 32‑bit cross package set for i686 Linux
  pkgs32 = pkgs.pkgsCross.i686-linux;
in {
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      # -- basic 64‑bit runtime
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

      # -- GTK / UI libraries
      glib
      gtk2
      gtk3
      pango
      cairo
      atk
      gdk-pixbuf
      fontconfig
      freetype

      # -- X11 / graphics stack
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
      libxcb-util
      libxcb-render-util
      libxcb-image

      # -- OpenGL / Mesa (64‑bit)
      libGL
      libGLU
      libgbm
      libdrm
      libvdpau
      libva
      libelf
      freeglut

      # -- Vulkan loader
      vulkan-loader

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

      # -- SDL (64‑bit)
      SDL
      SDL2
      SDL_image
      SDL_ttf
      SDL_mixer
      SDL2_image
      SDL2_ttf
      SDL2_mixer

      # -- system / runtime helpers
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

      # -- legacy / misc
      libxkbcommon
      libidn
      tbb
      libmikmod
      libudev0-shim
      libxcrypt
      libxcrypt-legacy
      fuse
      e2fsprogs
      
      # -- 32‑bit graphics / opengl / vulkan
      pkgs32.libGL
      pkgs32.libGLU
      pkgs32.mesa
      pkgs32.vulkan-loader

      # -- 32‑bit audio / SDL
      pkgs32.alsa-lib
      pkgs32.pulseaudio
      pkgs32.SDL2
      pkgs32.SDL2_mixer

      # -- 32‑bit terminal / misc
      pkgs32.ncurses
    ];
  };
}
