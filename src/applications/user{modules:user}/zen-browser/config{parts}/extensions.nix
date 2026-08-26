# -- implemented as a policy
{...}: let
  mk-extension = slug: {
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/${slug}/latest.xpi";
    installation_mode = "force_installed";
  };
in {
  "uBlock0@raymondhill.net" = mk-extension "ublock-origin";
  "ff2mpv@yossarian.net" = mk-extension "ff2mpv";
  "sponsorBlocker@ajay.app" = mk-extension "sponsorblock";
  "deArrow@ajay.app" = mk-extension "dearrow";
  "addon@darkreader.org" = mk-extension "darkreader";
  "*" = {
    installation_mode = "blocked";
  };
}
