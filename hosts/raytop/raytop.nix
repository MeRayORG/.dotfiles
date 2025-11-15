{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];



  networking = {
    hostName = "raytop"; # Define your hostname.
    networkmanager.enable = true; # Enable networking
  };




  ## See extraconfig.nix
  system.stateVersion = "25.05"; # Did you read the comment?
}
