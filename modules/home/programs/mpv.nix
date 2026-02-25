{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      uosc
      thumbfast
      youtube-upnext
      webtorrent-mpv-hook

      mpv-playlistmanager
      mpris

      evafast
    ];

    config = {
      profile = "gpu-hq";
      ytdl-format = "bestvideo+bestaudio";
      gpu-api = "vulkan";
      hwdec = "auto";
      cache = "yes";
      cache-secs = "20";
      demuxer-readahead-secs = "20";
      idle = "yes";
    };
  };
}
