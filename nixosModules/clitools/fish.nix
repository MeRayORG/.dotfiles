{ config, lib, pkgs, ... }: with lib;

{
  options.clitools.fish.enable = mkEnableOption "Enable fish.";

  config = mkIf config.clitools.fish.enable {
    environment.systemPackages = with pkgs; [
      fish
    ];
    users.defaultUserShell = pkgs.fish;
    programs.fish.enable = true;
  };



}
