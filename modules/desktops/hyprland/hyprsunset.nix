{ pkgs
, mkHome
, config
, lib
, ...
} @set :
let 

cfg = config.mods.desktops; 
enable = cfg.de == "hypr";

in 
lib.mkIf enable (mkHome set {
  services.hyprsunset.enable = true;
})