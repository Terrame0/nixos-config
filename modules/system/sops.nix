{...}: {
  sops.age.keyFile = "/home/terrame/age/keys.txt";
  environment.sessionVariables = {
    SOPS_AGE_KEY_FILE = "/home/terrame/age/keys.txt";
  };

  sops.secrets = {
    # -- secrets for configuring the xray config
    "xray/uuid" = {
      sopsFile = ../../secrets/xray-secrets2.yaml;
      key = "uuid";
    };
    "xray/server-ip" = {
      sopsFile = ../../secrets/xray-secrets2.yaml;
      key = "server-ip";
    };
    "xray/spiderx" = {
      sopsFile = ../../secrets/xray-secrets2.yaml;
      key = "spiderx";
    };
    "xray/sid" = {
      sopsFile = ../../secrets/xray-secrets2.yaml;
      key = "sid";
    };
    "xray/pubkey" = {
      sopsFile = ../../secrets/xray-secrets2.yaml;
      key = "pubkey";
    };
    "xray/path" = {
      sopsFile = ../../secrets/xray-secrets2.yaml;
      key = "path";
    };
    "xray/mldsa" = {
      sopsFile = ../../secrets/xray-secrets2.yaml;
      key = "mldsa";
    };
  };
}
