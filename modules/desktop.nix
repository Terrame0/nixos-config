{pkgs,...}:
{  
  # -- steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # -- services
  services.v2raya.enable = true;

  # -- system packages
  environment.systemPackages = with pkgs; [
    # -- cli tools
    alejandra
    nixd
    git
    clang
    clang-tools
    nix-ld
    python3

    # -- desktop apps
    kdePackages.kdenlive
    vscode-fhs
    telegram-desktop
    firefox
  ];
}