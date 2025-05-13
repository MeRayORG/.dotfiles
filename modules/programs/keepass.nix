{
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = [ pkgs.keepassxc];
  # disable gnome keyring to enable keepass as SecretService
  services.gnome.gnome-keyring.enable = lib.mkForce false;
}