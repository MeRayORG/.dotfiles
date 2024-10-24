{ config, lib, pkgs, ... }: with lib;

{
  options.clitools.starship.enable = mkEnableOption "Enable starship.";

  config = mkIf config.clitools.starship.enable {
    environment.systemPackages = with pkgs; [
      starship
      
    ];
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraMono" ]; })
    ];

  };
}
