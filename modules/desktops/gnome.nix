{ config
, lib
, mkHome
, pkgs
, ...
}:
let cfg = config.mods.desktops; in 
{ 
  config = lib.mkIf (cfg.de == "gnome") ({
    services = {
      xserver.enable = true;
      xserver.displayManager.gdm.enable = true;
      xserver.desktopManager.gnome.enable = true;
    };
  }// mkHome config {
    programs.gnome-shell.enable = true;
    programs.gnome-shell.extensions = [
      { package = pkgs.gnomeExtensions.paperwm; }
    ];
  });
}
