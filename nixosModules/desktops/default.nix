{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS;

in {
  myNixOS = {
    desktops.hyprland.enable = lib.mkIf (cfg.desktop == "hyprland");
    desktops.kde.enable = lib.mkIf (cfg.desktop == "hyprland");
  };

  options.myNixOS = {
    desktop = lib.mkOption {
      default = "none";
      type = lib.types.enum [
        "none"
        "kde"
        "hyprland"
      ];
    };
  };
  
  config = {
    warnings = [
      (lib.mkIf (cfg.desktop == "none") 
      "No desktop configured (desktop = [kde|hyprland])")
    ];
  };
}
