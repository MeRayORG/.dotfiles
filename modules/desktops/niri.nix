{ config
, lib
, ...
}:
let cfg = config.mods.desktops; in 
{ 
  config = lib.mkIf (cfg.de == "niri") {
    programs.niri = {
      enable = true;
    };
    services = {
      xserver.displayManager.gdm.enable = true;
      
    };
  };
}