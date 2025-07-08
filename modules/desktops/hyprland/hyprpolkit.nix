{ pkgs
, lib
, mkHome
, config
, ...
} :
let 

cfg = config.mods.desktops; 
enable = cfg.de == "hypr";

in 

  lib.mkIf enable (mkHome config {
    services.hyprpolkitagent.enable = true;
  })