{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc

      thumbfast
      youtube-upnext
      webtorrent-mpv-hook

      mpv-playlistmanager

      sponsorblock

      mpris
      #memo

      evafast

      #eisa01.undoredo
      #eisa01.smartskip
      #eisa01.simplehistory
    ];
  };
}
