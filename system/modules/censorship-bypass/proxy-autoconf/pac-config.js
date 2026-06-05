function FindProxyForURL(url, host) {
  host = host.toLowerCase();
    
  // -- domains that go through proxy
  var proxyDomains = [
    // -- meta
    "instagram.com",
    "cdninstagram.com",
    "facebook.com",
    "fbcdn.net",
    "fbsbx.com",
    "whatsapp.com",
    "whatsapp.net",
    "fb.com",
    "facebook.net",
    "fb.me",
    "fb.watch",
    "instagram.net",

    // -- nixos binary cache
    "cache.nixos.org",

    // -- twitter
    "x.com",
    "twitter.com",
    "t.co",
    "twimg.com",
    "twttr.com",

    // -- communication
    "telegram.org",
    "t.me",
    "telegram.me",
    "cdn.telesco.pe",
    "zoom.us",
    "zoom.com",

    // -- social
    "reddit.com",
    "redditstatic.com",
    "medium.com",
    "discord.com",
    "discord.gg",
    "discordapp.com",
    "discordapp.net",

    // -- twitch
    "twitch.tv",
    "ttvnw.net",
    "jtvnw.net",

    // -- ai
    "anthropic.com",
    "claude.ai",
    "perplexity.ai",
    "notion.so",
    "chatgpt.com",
    "openai.com",
    
    // -- ip checkers
    "ipleak.net",
    "browserleaks.com",
    "dnsleaktest.com",
    "whoer.net",
    "ipleak.org",
    "ip-api.com",
    "checkip.amazonaws.com",
    "api.ipify.org",
    "ipinfo.io",
    "icanhazip.com",

    // -- steam cdn (for cloud sync)
    "steamcloud-tyo.s3.dualstack.ap-northeast-1.amazonaws.com",
    "steamcloud-us-east.s3.dualstack.us-east-1.amazonaws.com",
    "steamcloudsweden.blob.core.windows.net",
    "steamcloudams2.blob.core.windows.net",
    "steamcloudlrstyo.blob.core.windows.net",
    "steamcloud-tokyo.storage.googleapis.com",

    // -- torrents
    "rutracker.org",
    "bt4g.org",
    "bt4gprx.com",
    "downloadtorrentfile.com",

    // -- misc
    "mpv.io",
    "github.com",
    "githubusercontent.com",
    "extranix.com",
    "nixos.org",
    "nix.dev",
    "desmos.com",
    "wikipedia.org",
    "wikimedia.org",
    "archive.org",
    "itsfoss.com",
    "starship.rs",
    "dota2mapdrawing.com",
    "onlinegdb.com"
  ];

  // -- matches domain or subdomain
  function isInDomain(h, domain) {
    return (h === domain) || dnsDomainIs(h, "." + domain);
  }

  // -- use xray if the host is in the list above
  for (var i = 0; i < proxyDomains.length; i++) {
    if (isInDomain(host, proxyDomains[i])) {
      return "PROXY 127.0.0.1:10808";
    }
  }

  // -- everything else goes direct
  return "DIRECT";
}