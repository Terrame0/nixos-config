{...}: {
  virtualisation.docker.rootless = {
    setSocketVariable = true;
    enable = true;
  };
}
