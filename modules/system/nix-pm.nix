{...}: {
  nixpkgs.config.allowUnfree = true;
  # nix.settings = {
  #   experimental-features = ["nix-command" "flakes"];
  #   http-proxy = "http://127.0.0.1:8080";
  #   https-proxy = "http://127.0.0.1:8080";
  # };
}
