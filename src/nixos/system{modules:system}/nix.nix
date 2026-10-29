{inputs, ...}: {
  nix = {
    registry = {
      default.flake = inputs.nixpkgs;
      sundry.flake = inputs.sundry-flake;
    };
    gc = {
      automatic = true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise = {
      automatic = true;
      persistent = true;
      dates = "weekly";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      connect-timeout = 20;
      stalled-download-timeout = 300;
      # -- HTTP/2 framing errors on the caches here are retried from offset
      # - HTTP/1.1 has no framing layer, so it avoids them
      http2 = false;
      extra-substituters = [
        "https://watersucks.cachix.org" # -- nixos cli
        "https://cache.lantian.pub/lantian" # -- cachyos kernels
        "https://cache.xinux.uz"
        "https://hyprland.cachix.org" # -- hyprland
        "https://numtide.cachix.org" # -- numtide stuff
      ];
      extra-trusted-public-keys = [
        "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
        "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
  };
}
