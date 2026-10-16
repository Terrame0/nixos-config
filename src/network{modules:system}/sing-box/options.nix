{lib, ...}: {
  options = {
    networking.proxied-domains = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "A list of all domains proxied by sing-box, matched by domain suffix";
    };
  };
}
