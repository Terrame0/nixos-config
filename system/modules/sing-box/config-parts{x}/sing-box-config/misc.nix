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
}
