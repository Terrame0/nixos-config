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
      force-window = true;
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
      gpu-api = "vulkan";
      hwdec = "auto";
      cache = "yes";
      cache-secs = "30";
      demuxer-max-bytes = "500MiB";
      demuxer-readahead-secs = "20";
      idle = "yes";
    };
  };
}
