{
  inputs,
  ...
}: let
  inherit (inputs) home;
in {
  home-manager.nixosModules.home-manager = {
    home-manager.stateVersion = "24.05";
    programs.home-manager.enable = true;
  };


}