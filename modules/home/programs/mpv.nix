{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      ff2mpv
      thumbfast
      youtube-upnext
      webtorrent-mpv-hook

      mpv-playlistmanager
      mpris

      evafast
    ];
  };
}
