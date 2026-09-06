{...}: {
  search = {
    suspended_times = {
      SearxEngineTooManyRequests = 60;
      SearxEngineCaptcha = 600;
      cf_SearxEngineCaptcha = 86400;
      cf_SearxEngineAccessDenied = 21600;
    };
    favicon_resolver = "duckduckgo";
    autocomplete = "duckduckgo";
    autocomplete_min = 4;
    ban_time_on_fail = 10;
    max_ban_time_on_fail = 300;
  };
}
