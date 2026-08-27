# -- implemented as a policy
{lock, ...}: {
  # -- network
  "network.trr.mode" = lock 2;
  "network.trr.uri" = lock "https://dns.cloudflare.com/dns-query";
  "network.proxy.type" = lock 0;

  # -- zen layout and ui
  "zen.view.sidebar-expanded" = lock true;
  "zen.view.use-single-toolbar" = lock true;
  "zen.view.compact.enable-at-startup" = lock true;
  "zen.view.compact.toolbar-flash-popup" = lock true;
  "zen.view.drag-window-from-content" = lock false;
  "zen.view.show-newtab-button-top" = lock false;
  "zen.tabs.show-newtab-vertical" = lock true;
  "zen.urlbar.behavior" = lock "floating-on-type";
  "browser.uidensity" = lock 1;
  "browser.toolbars.bookmarks.visibility" = lock "never";

  # -- zen tabs and workspaces
  "zen.glance.enabled" = lock true;
  "zen.glance.activation-method" = lock "alt";
  "zen.workspaces.continue-where-left-off" = lock true;
  "zen.workspaces.separate-essentials" = lock true;
  "zen.workspaces.open-new-tab-if-last-unpinned-tab-is-closed" = lock false;
  "zen.tabs.ctrl-tab.ignore-essential-tabs" = lock true;
  "zen.tabs.ctrl-tab.ignore-pending-tabs" = lock false;
  "zen.tabs.select-recently-used-on-close" = lock false;
  "zen.mods.auto-update" = lock true;

  # -- tabs and session
  "browser.link.open_newwindow" = lock 3;
  "browser.link.open_newwindow.override.external" = lock (-1);
  "browser.tabs.loadInBackground" = lock true;
  "browser.ctrlTab.sortByRecentlyUsed" = lock false;
  "browser.tabs.dragDrop.createGroup.enabled" = lock true;
  "browser.tabs.warnOnClose" = lock false;
  "browser.warnOnQuitShortcut" = lock true;
  "browser.tabs.closeWindowWithLastTab" = lock true;
  "browser.sessionstore.resume_from_crash" = lock true;
  "browser.sessionstore.restore_on_demand" = lock true;
  "browser.sessionstore.restore_pinned_tabs_on_demand" = lock true;

  # -- containers, search, and forms
  "privacy.userContext.ui.enabled" = lock true;
  "privacy.userContext.enabled" = lock true;
  "browser.search.separatePrivateDefault.ui.enabled" = lock false;
  "browser.search.showOneOffButtons" = lock false;
  "browser.translations.automaticallyPopup" = lock false;
  "browser.urlbar.focusOnNewTab" = lock true;
  "signon.rememberSignons" = lock true;
  "browser.formfill.enable" = lock true;
  "browser.aboutConfig.showWarning" = lock false;

  # -- accessibility and page appearance
  "accessibility.browsewithcaret" = lock false;
  "accessibility.typeaheadfind" = lock false;
  "general.autoScroll" = lock true;
  "general.smoothScroll" = lock true;
  "widget.gtk.overlay-scrollbars.enabled" = lock true;
  "layout.css.always_underline_links" = lock false;
  "browser.zoom.full" = lock true;
  "browser.display.document_color_use" = lock 1;
  "font.default.x-western" = lock "serif";
  "font.name.serif.x-western" = lock "JetBrainsMono Nerd Font Propo";
  "font.size.variable.x-western" = lock 16;
  "media.hardwaremediakeys.enabled" = lock true;

  # -- media and performance
  "media.videocontrols.picture-in-picture.video-toggle.enabled" = lock true;
  "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = lock true;
  "browser.preferences.defaultPerformanceSettings.enabled" = lock true;
  "browser.cache.disk.enable" = lock true;
  "browser.sessionstore.interval" = lock 15000;

  # -- safety and platform integration
  "browser.safebrowsing.malware.enabled" = lock true;
  "browser.safebrowsing.phishing.enabled" = lock true;
  "widget.disable-workspace-management" = lock true;
}
