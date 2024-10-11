{ config, lib, pkgs, ... }: with lib;

{
  options.clitools.utils.enable = mkEnableOption "Enable Utils.";

  config = mkIf config.clitools.utils.enable {
    environment.systemPackages = with pkgs; [
      tree
      eza
      unrar
    ];
  };



}
