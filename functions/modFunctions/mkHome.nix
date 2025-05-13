{
  pkgs,
  lib,
  config,
  ...
}:
homeOptions:
{
home-manager.users =
lib.genAttrs
  config.homemanager.users
  (user:
    { pkgs, ... }: ({
      home.username = "${user}";
      home.homeDirectory = "/home/${user}";
      programs.home-manager.enable = true;
      home.stateVersion = "24.11";  # Specify the NixOS version
    } // homeOptions)
  );
}