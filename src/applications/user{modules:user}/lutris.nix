{pkgs, ...}: {
  vpn.domain-list = [
    "lutris.net"
    "lutris.nyc3.cdn.digitaloceanspaces.com"
  ];
  home.packages = [pkgs.lutris];
}
