{paths, ...}: {
  log = {
    level = "debug";
    timestamp = true;
  };

  experimental.cache_file = {
    enabled = true;
    path = "${paths.state-dir}/cache.db";
    store_fakeip = true;
  };

  experimental.clash_api = {
    external_controller = "127.0.0.1:9090";
    access_control_allow_origin = ["https://metacubex.github.io"];
    access_control_allow_private_network = true;
  };
}
