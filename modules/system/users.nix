{...}: {
  users.users.terrame = {
    isNormalUser = true;
    description = "Terrame";
    extraGroups = ["networkmanager" "wheel"];
    packages = [];
  };
}
