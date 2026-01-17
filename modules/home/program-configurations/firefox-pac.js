function FindProxyForURL(url, host) {

  host = host.toLowerCase();
    
  // -- domains that go through proxy
  const proxyDomains = [

    // -- meta
    "instagram.com",
    "cdninstagram.com",
    "facebook.com",
    "fbcdn.net",
    "fbsbx.com",
    "whatsapp.com",
    "whatsapp.net",

    // -- x
    "x.com",
    "twitter.com",
    "t.co",
    "twimg.com",

    // -- messengers
    "signal.org",
    "cdn.signal.org",
    "snapchat.com",
    "sc-cdn.net",

    // -- games
    "roblox.com",
    "rbxcdn.com",
    "robloxcdn.com",

    // -- media
    "bbc.com",
    "bbc.co.uk",
    "meduza.io",
    "theguardian.com",
    "nytimes.com",
    "dw.com",
    "rferl.org",

    // -- misc
    "rutracker.org",
    "cloudflareinsights.com",
    "cloudfront.net",
  ];

  // -- matches domain or subdomain
  function isInDomain(h, domain) {
    return (h === domain) || dnsDomainIs(h, "." + domain);
  }

  // -- use xray if the host is in the list above
  for (let i = 0; i < proxyDomains.length; i++) {
    if (isInDomain(host, proxyDomains[i])) {
      return "SOCKS5 127.0.0.1:10808; DIRECT";
    }
  }

  // -- everything else goes direct
  return "DIRECT";
}
