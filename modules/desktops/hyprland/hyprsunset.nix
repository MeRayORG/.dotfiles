{ pkgs
, mkHome
, config
, lib
, ...
} :
let 

cfg = config.mods.desktops; 
enable = cfg.de == "hypr";

in 
lib.mkIf enable (mkHome config {
  services.hyprsunset.enable = true;
})