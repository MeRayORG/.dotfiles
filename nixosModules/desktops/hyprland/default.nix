{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (inputs) nixpkgs hyprpanel;
  cfg = config.myNixOS;

  hyprlandmodule = lib.mkIf (cfg.desktop == "hyprland") {
    import = [
    ./hyprpanel
    ];
    environment.systemPackages = [pkgs.hyprland];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

  };

in hyprlandmodule
