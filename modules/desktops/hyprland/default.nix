{ pkgs
, config
, lib
, mkHome
, mapDir
, ...
}@set:
let 

cfg = config.mods.desktops; 
enable = cfg.de == "hypr";

in 
{
  imports = [
    ./hyprsunset.nix
    ./hyprlock.nix
    ./hyprpolkit.nix
  ];
  config = lib.mkIf enable ({
    programs = {
      # HYPRLAND
      hyprland = {
        enable = true;
        xwayland.enable = cfg.xway;
        withUWSM = true;
      };
      # HYPRLOCKs
      hyprlock.enable = true;
    };
    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };
    environment.systemPackages = [ 
      pkgs.wofi
      pkgs.eww
      pkgs.pipewire
      pkgs.hyprpaper
    ] ++ lib.mapAttrsToList (pkgs.writeShellScriptBin) (mapDir ./scripts false ({tf,...}: tf.script));
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;


  } // mkHome config {
    wayland.windowManager.hyprland = 
      let 
        plugins = ((import ./plugins) set);
      in {
      enable = true;
      package = null;
      portalPackage = null;
      settings = ((import ./config) set) // plugins.settings;
      plugins = plugins.pkgs;
    };
  });
}
