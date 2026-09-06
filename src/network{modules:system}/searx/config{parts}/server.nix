{...}: {
  server = {
    base_url = "http://localhost:8888";
    secret_key = "$SEARXNG_SECRET";
    limiter = false;
    image_proxy = true;
  };
  outgoing = {
    pool_connections = 100;
    request_timeout = 3.0;
    max_request_timeout = 7.0;
  };
}
