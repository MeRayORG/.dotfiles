{ pkgs
, mkHome
, config
, ...
}:
{
  environment.systemPackages = with pkgs; [
    pipewire 
    wireplumber 
    xdg-desktop-portal
    kdePackages.xdg-desktop-portal-kde
  ] ++ (if config.mods.desktops.xway then [libsForQt5.xwaylandvideobridge] else []);


} // mkHome config {
  xdg.configFile."xdg-desktop-portal/hyprland-portals.conf" = ''
    [preferred]
    default = hyprland;gtk
    org.freedesktop.impl.portal.FileChooser = kde
  '';
}