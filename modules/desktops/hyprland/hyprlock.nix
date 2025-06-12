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
{
  config = lib.mkIf enable ({
    security.pam.services.hyprlock = {};  
  } //
  mkHome set {
    programs.hyprlock.enable = true;
  }); 
}