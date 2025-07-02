{ config
, lib
, ...
}:
let cfg = config.mods.desktops; in 
{ 
  config = lib.mkIf (cfg.de == "gnome") {
    services = {
      xserver.enable = true;
      xserver.displayManager.gdm.enable = true;
      xserver.desktopManager.gnome.enable = true;
    };
  };
}
