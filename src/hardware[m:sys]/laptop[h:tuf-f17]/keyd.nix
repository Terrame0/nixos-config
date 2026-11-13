{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    keyd
  ];
  # -- fix for touchpad toggle activating twice
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings = {
        main = {
          # -- ignoring the ACPI toggle event
          touchpadtoggle = "noop";
        };
      };
    };
  };
}
