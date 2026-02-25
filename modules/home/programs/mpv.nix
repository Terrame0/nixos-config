{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      webtorrent-mpv-hook
      mpv-playlistmanager
      mpris
      evafast
    ];

    config = {
      ytdl-format = "bestvideo+bestaudio";
      cache = "yes";
      cache-secs = "20";
      demuxer-readahead-secs = "20";
      idle = "yes";
    };
  };
}
