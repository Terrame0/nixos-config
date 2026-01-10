{...}: {
  services.zapret = {
    enable = true;

    params = [
      # -- http
      "--filter-tcp=80 <HOSTLIST>"
      "--dpi-desync=fake,fakedsplit"
      "--dpi-desync-autottl=2"
      "--dpi-desync-fooling=md5sig"
      "--new"

      # -- https
      "--filter-tcp=443 <HOSTLIST>"
      "--dpi-desync=fake,multidisorder"
      "--dpi-desync-fooling=badseq"
      "--dpi-desync-split-pos=midsld"
      "--dpi-desync-fake-tls=0x00000000"
    ];

    whitelist = [
      # -- discord
      "discord.com"
      "app.discord.com"
      "discordapp.com"
      "discordcdn.com"

      # -- youtube
      "youtube.com"
      "youtu.be"
      "ytimg.com"
      "googlevideo.com"
      "gvt1.com"
      "ggpht.com"
      "youtubei.googleapis.com"
      "youtube.googleapis.com"
      "youtube-nocookie.com"

      # -- steam
      "store.steampowered.com"
      "steamcommunity.com"
      "steamusercontent.com"
      "steamcdn-a.akamaihd.net"
      "steamstatic.com"
      "steampowered.com"
      "api.steampowered.com"

      # -- modrinth
      "modrinth.com"
      "api.modrinth.com"
      "cdn.modrinth.com"

      # -- curseforge
      "curseforge.com"
      "api.curseforge.com"
      "mediafiles.forgecdn.net"
      "edge.forgecdn.net"
    ];
  };
}
