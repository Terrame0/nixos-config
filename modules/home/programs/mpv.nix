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

      mpris
      memo

      mpv-image-viewer.image-positioning
      mpv-image-viewer.status-line

      evafast

      eisa01.undoredo
      eisa01.smartskip
      eisa01.simplehistory
    ];
  };
}
