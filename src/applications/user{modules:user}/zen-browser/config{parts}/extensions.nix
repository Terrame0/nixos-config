# -- implemented as a policy
{...}: {
  "uBlock0@raymondhill.net" = {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    installation_mode = "force_installed";
  };
  "ff2mpv@yossarian.net" = {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/ff2mpv/latest.xpi";
    installation_mode = "force_installed";
  };
  "*" = {
    installation_mode = "blocked";
  };
}
