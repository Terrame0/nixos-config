{pkgs, ...}: {
  sing-box.proxied-domains = [
    "downloadtorrentfile.com"
    "rutracker.org"
    "rutracker.net"
    "bt4gprx.com"
    "bt4g.com"
    "bt4g.org"
  ];
  home.packages = [pkgs.qbittorrent];
}
