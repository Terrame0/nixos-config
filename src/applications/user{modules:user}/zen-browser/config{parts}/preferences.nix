# -- implemented as a policy
{lock, ...}: {
  # -- dns over https
  "network.trr.mode" = lock 2;
  "network.trr.uri" = lock "https://dns.cloudflare.com/dns-query";

  # -- proxy
  "network.proxy.type" = lock 0;

  # -- session restore
  "browser.sessionstore.resume_from_crash" = lock true;
  "browser.sessionstore.resume_session_once" = lock false;

  # -- new tab behaviour
  "browser.urlbar.focusOnNewTab" = lock true;
  "browser.toolbars.bookmarks.visibility" = lock "never";

  # -- search and translations
  "browser.search.separatePrivateDefault.ui.enabled" = lock false;
  "browser.search.showOneOffButtons" = lock false;
  "browser.translations.automaticallyPopup" = lock false;

  # -- password and forms
  "signon.rememberSignons" = lock true;
  "browser.formfill.enable" = lock true;

  # -- ui
  "browser.aboutConfig.showWarning" = lock false;
  "browser.uidensity" = lock 1;

  # -- tab behaviour
  "browser.tabs.warnOnClose" = lock false;
  "browser.tabs.closeWindowWithLastTab" = lock true;

  # -- performance
  "browser.cache.disk.enable" = lock true;
  "browser.sessionstore.interval" = lock 15000;

  # -- workspace
  "widget.disable-workspace-management" = lock true;

  # -- safe browsing
  "browser.safebrowsing.malware.enabled" = lock true;
  "browser.safebrowsing.phishing.enabled" = lock true;
}
