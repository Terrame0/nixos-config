{...}: {
  server = {
    base_url = "http://localhost:8888";
    secret_key = "$SEARXNG_SECRET";
    limiter = false;
    image_proxy = true;
  };
  outgoing = {
    pool_connections = 20;
    request_timeout = 10.0;
    max_request_timeout = 15.0;
  };
}
