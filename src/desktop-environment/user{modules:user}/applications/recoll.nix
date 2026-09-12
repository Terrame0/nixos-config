{config, ...}: {
  services.recoll = {
    enable = true;
    startAt = "hourly";
    settings = {
      topdirs = with config.xdg.userDirs; [
        documents
        download
        pictures
        videos
        music
        projects
      ];
    };
  };
}
