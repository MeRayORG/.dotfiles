{ pkgs
, config
, lib
, mkHome
, ...
} @set:
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
      pkgs.foot
      pkgs.wofi
      pkgs.yazi
      pkgs.eww
      pkgs.kitty
      pkgs.pipewire

    ];
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

  } // mkHome set {
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
