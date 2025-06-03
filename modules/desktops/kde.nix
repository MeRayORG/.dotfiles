{ config
, lib
, ...
}: 

{ 
  config = lib.mkIf (config.mods.desktops.de == "kde") {
    services = {
        displayManager.sddm = {
          wayland.enable = true;
          enable = true;
        };

        desktopManager.plasma6.enable = true;
    };
  };
}
