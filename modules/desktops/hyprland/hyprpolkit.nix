{ pkgs
, lib
, mkHome
, config
, ...
} @set :
let 

cfg = config.mods.desktops; 
enable = cfg.de == "hypr";

in 

  lib.mkIf enable (mkHome set {
    services.hyprpolkitagent.enable = true;
  })