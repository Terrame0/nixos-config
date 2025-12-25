{pkgs,...}:
{  
  # -- steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # -- zsh
  programs.zsh.enable = true;

  # -- system packages
  environment.systemPackages = with pkgs; [

    # -- gnome whatevers
    gnome-tweaks
    gnome-extension-manager
    gnomeExtensions.clipboard-history
    gnomeExtensions.battery-time

    # -- cli tools
    alejandra
    nixd
    git
    clang
    clang-tools
    nix-ld
    python3
    uv
    neofetch
    v2rayn
    xray

    # -- desktop apps
    kdePackages.kdenlive
    telegram-desktop
    firefox
    vscode-fhs 
  ];
}