{config, ...}: {
  sops.templates."xray-config".content = builtins.toJSON {
    log.loglevel = "warning";
    inbounds = [
      {
        tag = "socks";
        port = 10808;
        listen = "127.0.0.1";
        protocol = "mixed";
        sniffing = {
          enabled = true;
          destOverride = ["http" "tls"];
        };
        settings = {
          auth = "noauth";
          udp = true;
          allowTransparent = false;
        };
      }
    ];
    outbounds = [
      {
        tag = "proxy";
        protocol = "vless";
        settings.vnext = [
          {
            address = config.sops.placeholder."xray/server_ip";
            port = 40090;
            users = [
              {
                id = config.sops.placeholder."xray/uuid";
                email = "t@t.tt";
                security = "auto";
                encryption = "none";
              }
            ];
          }
        ];
        streamSettings = {
          network = "xhttp";
          security = "reality";
          xhttpSettings = {
            path = config.sops.placeholder."xray/path";
            mode = "auto";
          };
          realitySettings = {
            serverName = "google.com";
            fingerprint = "chrome";
            show = false;
            publicKey = config.sops.placeholder."xray/pubkey";
            shortId = config.sops.placeholder."xray/sid";
            spiderX = config.sops.placeholder."xray/spiderx";
            mldsa65Verify = config.sops.placeholder."xray/mldsa";
          };
        };
        mux.enabled = false;
      }
      {
        tag = "direct";
        protocol = "freedom";
      }
    ];
    routing = {
      domainStrategy = "IPIfNonMatch";
      rules = [
        {
          type = "field";
          ip = ["geoip:private"];
          outboundTag = "direct";
        }
        {
          type = "field";
          outboundTag = "direct";
          domain = ["geosite:private"];
        }
        {
          type = "field";
          network = "udp,tcp";
          outboundTag = "proxy";
        }
      ];
    };
  };

  services.xray = {
    enable = true;
    settingsFile = config.sops.templates."xray-config".path;
  };
}
