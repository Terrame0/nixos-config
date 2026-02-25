{pkgs,...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [ 
      uosc
      thumbfast 
      youtube-upnext
      webtorrent-mpv-hook
      command_palette
      playlistmanager
      autosave-state
      sponsorblock
      file-browser
    ];
  };
}
