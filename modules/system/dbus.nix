{lib, ...}: {
  services.dbus.implementation = lib.mkForce "dbus";
}
