{
  inputs,
  ...
}: let
  inherit (inputs) home;
in {
    home.stateVersion = "24.05";
    programs.home-manager.enable = true;
}