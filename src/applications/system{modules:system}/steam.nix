{pkgs, ...}: {
  # -- cloud sync backends
  sing-box.proxied-domains = [
    "steamcloud-tyo.s3.dualstack.ap-northeast-1.amazonaws.com"
    "steamcloud-us-east.s3.dualstack.us-east-1.amazonaws.com"
    "steamcloudsweden.blob.core.windows.net"
    "steamcloudams2.blob.core.windows.net"
    "steamcloudlrstyo.blob.core.windows.net"
    "steamcloud-tokyo.storage.googleapis.com"
  ];
  programs.steam = {
    enable = true;
    extraCompatPackages = [pkgs.proton-ge-bin];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
