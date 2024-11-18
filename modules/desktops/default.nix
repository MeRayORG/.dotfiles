{
  config,
  lib,
  ...
}: let
  cfg = config.myNixOS;

in {
  imports = [
    ./hyprland
    ./kde.nix
  ];

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
