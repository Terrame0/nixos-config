{...}: {
  programs.nix-your-shell = {
    enable = true;
    enableNushellIntegration = true;
    nix-output-monitor.enable = true;
  };
}
