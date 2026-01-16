{...}: {
  sops.age.keyFile = "/home/terrame/age/keys.txt";

  sops.secrets = {
    # -- secrets for configuring the xray config
    "xray/uuid" = {
      sopsFile = ../../secrets/xray-secrets.yaml;
      key = "uuid";
    };
    "xray/server_ip" = {
      sopsFile = ../../secrets/xray-secrets.yaml;
      key = "server_ip";
    };
    "xray/spiderx" = {
      sopsFile = ../../secrets/xray-secrets.yaml;
      key = "spiderx";
    };
    "xray/sid" = {
      sopsFile = ../../secrets/xray-secrets.yaml;
      key = "sid";
    };
    "xray/pubkey" = {
      sopsFile = ../../secrets/xray-secrets.yaml;
      key = "pubkey";
    };
    "xray/path" = {
      sopsFile = ../../secrets/xray-secrets.yaml;
      key = "path";
    };
    "xray/mldsa" = {
      sopsFile = ../../secrets/xray-secrets.yaml;
      key = "mldsa";
    };
  };
}
