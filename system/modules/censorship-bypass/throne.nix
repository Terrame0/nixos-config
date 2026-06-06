{...}: {
  programs.throne = {
    tunMode.enable = false; # -- breaks bwrap
    enable = true;
  };
}
