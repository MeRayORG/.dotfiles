{
  pkgs,
  lib,
  config,
  ...
}: let 

  cfg = config.myNixOS;

  kdemodule = lib.mkIf (cfg.desktop == "hyprland") {
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
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    };
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

  };

in kdemodule