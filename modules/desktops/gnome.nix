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
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  }// mkHome config {
    programs.gnome-shell= {
      enable = true;
      programs.gnome-shell.extensions = [
        { package = pkgs.gnomeExtensions.paperwm; }
      ];
    };});
}
