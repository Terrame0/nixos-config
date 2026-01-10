{...}: {
  services.zapret = {
    enable = true;
    configureFirewall = true;
    httpSupport = true;
    udpSupport = true;
    udpPorts = ["50000:60000"]; # -- for voice channels

    # -- dpi bypass strategies
    params = [
      "--filter-tcp=80 --dpi-desync=fake,multisplit --dpi-desync-split-pos=method+2 --dpi-desync-fooling=md5sig --new"
      "--filter-tcp=443 --dpi-desync=fake,multidisorder --dpi-desync-split-pos=1,midsld --dpi-desync-fooling=badseq,md5sig --new"
    ];
    # -- bypass whitelist
    whitelist = [
      # -- youtube
      "youtube.com"
      "youtu.be"
      "youtube-nocookie.com"
      "ytimg.com"
      "googlevideo.com"
      # -- discord
      "discord.com"
      "discordapp.com"
      "discord.gg"
      "discordcdn.com"
      "cdn.discordapp.com"
      # -- steam
      "store.steampowered.com"
      "steamcommunity.com"
      "steampowered.com"
      "steamcdn.com"
      "valvecdn.com"
      "steamgames.com"
      "steamstatic.com"
      # -- modrinth
      "api.modrinth.com"
      "cdn.modrinth.com"
      "images.modrinth.com"
      # -- curseforge
      "api.curseforge.com"
      "minecraft.curseforge.com"
      "mediafiles.forgecdn.net"
      "edge.forgecdn.net"
    ];
  };
}
