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
{
  config = lib.mkIf enable ({
    security.pam.services.hyprlock = {};  
  } //
  mkHome config {
    programs.hyprlock.enable = true;
  }); 
}