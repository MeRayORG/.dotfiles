{ pkgs
, config
, lib
, ...
}:
let 

cfg = config.mods.desktops; 
enable = cfg.de == "hypr";

in 
{
  # imports = if !enable then [] else [
  #   ./hyprsunset.nix
  #   ./hyprlock.nix
  #   ./hyprpolkit.nix
  # ];
  config = lib.mkIf enable {
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

    ];
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    hardware.bluetooth.enable = true;

    # wayland.windowManager.hyprland = {
    #   enable = true;
    #   plugins = [
    #     #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    #     # ...
    #   ];
    # };
  };
}
