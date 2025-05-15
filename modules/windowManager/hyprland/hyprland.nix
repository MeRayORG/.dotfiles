{ config, lib, pkgs, ... }: with lib;

{
    imports = [
    ./end4.nix
    ];
    programs.hyprland.enable = true;
    services = {
      displayManager.sddm = {
        enable = true;
        wayland = {
          enable = true;
          compositor = "weston";
        };
      };
  };



}
