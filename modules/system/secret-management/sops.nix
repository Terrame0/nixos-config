{config, ...}: {
  sops.age.keyFile = "/home/terrame/age/keys.txt";
  environment.variables = {
    SOPS_AGE_KEY_FILE = "/home/terrame/age/keys.txt";
  };

  sops.secrets = {
    # -- secrets for configuring the xray config
    "xray/uuid" = {
      sopsFile = ./secrets/xray-secrets.yaml;
      key = "uuid";
    };
    "xray/server-ip" = {
      sopsFile = ./secrets/xray-secrets.yaml;
      key = "server-ip";
    };
    "xray/spiderx" = {
      sopsFile = ./secrets/xray-secrets.yaml;
      key = "spiderx";
    };
    "xray/sid" = {
      sopsFile = ./secrets/xray-secrets.yaml;
      key = "sid";
    };
    "xray/pubkey" = {
      sopsFile = ./secrets/xray-secrets.yaml;
      key = "pubkey";
    };
    "xray/path" = {
      sopsFile = ./secrets/xray-secrets.yaml;
      key = "path";
    };
    "xray/mldsa" = {
      sopsFile = ./secrets/xray-secrets.yaml;
      key = "mldsa";
    };
    # -- ssh private keys
    "ssh-keys/personal" = {
      sopsFile = ./secrets/ssh-keys.yaml;
      key = "personal";
    };
    "ssh-keys/github" = {
      sopsFile = ./secrets/ssh-keys.yaml;
      key = "github";
    };
    # -- authorized keys
    "ssh/authorized-keys" = {
      sopsFile = ./secrets/authorized-ssh-keys.yaml;
      key = "authorized-keys";
    };

    "${config.style.palette.red}" = {
      sopsFile = ./secrets/authorized-ssh-keys.yaml;
      key = "authorized-keys";
    };
  };
}
