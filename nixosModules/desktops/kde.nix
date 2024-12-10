{
  pkgs,
  lib,
  config,
  ...
}: {
  services = {

    xserver = {

      # Enable the X11 windowing system.
      # You can disable this if you're only using the Wayland session.
      enable = true;

      # Configure keymap in X11
      layout = "us";
      xkbVariant = "alt-intl";
    };

    # Enable the KDE Plasma Desktop Environment.
    displayManager.sddm = {
      enable = true;
      # wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };
}
