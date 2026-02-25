{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc

      thumbfast
      youtube-upnext
      youtube-chat
      webtorrent-mpv-hook
      mpv-playlistmanager
      sponsorblock

      autosave-state
      file-browser
      mpris
      memo
      mpv-image-viewer
      evafast
      eisa01
    ];
  };
}
