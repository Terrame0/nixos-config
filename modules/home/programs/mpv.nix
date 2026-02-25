{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      youtube-upnext
      youtube-chat
      webtorrent-mpv-hook
      playlistmanager
      autosave-state
      sponsorblock
      file-browser
      mpris
      memo

      mpv-image-viewer

      evafast

      eisa01

    ];
  };
}
