{pkgs, ...}: {
  home.packages = with pkgs; [
    ff2mpv
  ];

  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc

      thumbfast
      youtube-upnext
      webtorrent-mpv-hook

      mpv-playlistmanager
      mpris
      sponsorblock

      evafast
      eisa01.undoredo
      eisa01.smartskip
    ];
  };
}
