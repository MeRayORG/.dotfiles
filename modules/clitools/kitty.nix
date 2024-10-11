{ config, lib, pkgs, ... }: with lib;

{
  options.clitools.kitty.enable = mkEnableOption "Enable kitty.";

  config = mkIf config.clitools.kitty.enable {
    environment.systemPackages = with pkgs; [
      kitty
    ];
  };
}
