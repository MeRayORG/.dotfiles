{
  inputs,
  pkgs,
  config,
  ...
}: let
  inherit (inputs) nixpkgs hyprpanel;
in {
  nixpkgs.overlays = [hyprpanel.overlay];
  environment.systemPackages = [
    pkgs.hyprpanel
  ];
}
