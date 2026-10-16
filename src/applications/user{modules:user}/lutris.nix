{pkgs, ...}: {
  sing-box.proxied-domains = [
    "lutris.net"
    "lutris.nyc3.cdn.digitaloceanspaces.com"
  ];
  home.packages = [pkgs.lutris];
}
