{ config
, lib
, ...
}: 

{ 
  config = lib.mkIf (config.mods.desktops.de == "kde") {
    services = {

      xserver = {

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
  };
}