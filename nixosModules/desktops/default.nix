{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS;

in {
  myNixOS = {
    desktops.hyprland.enable = lib.mkIf (cfg.desktop == "hyprland");
    desktops.kde.enable = lib.mkIf (cfg.desktop == "kde");
    desktops.cosmic.enable = lib.mkIf (cfg.desktop == "cosmic");
  };

  options.myNixOS = {
    desktop = lib.mkOption {
      default = "none";
      type = lib.types.enum [
        "none"
        "kde"
        "hyprland"
        "cosmic"
      ];
    };
  };
  
  config = {
    warnings = [
      (lib.mkIf (cfg.desktop == "none") 
      "No desktop configured (desktop = [kde|hyprland|cosmic])")
    ];
  };
}
