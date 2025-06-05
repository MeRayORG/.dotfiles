{ config
, lib
, ...
}:
let cfg = config.mods.desktops; in 
{ 
  config = lib.mkIf (cfg.de == "kde") {
    services = {
        displayManager.sddm = {
          wayland.enable = true;
          enable = true;
        };
        desktopManager.plasma6.enable = true;
    };
  };
}
