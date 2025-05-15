{ config, lib, pkgs, ... }: with lib;

{
  options.clitools.zsh.enable = mkEnableOption "Enable zsh.";

  config = mkIf config.clitools.zsh.enable {
    environment.systemPackages = with pkgs; [
      zsh 
    ];
    users.defaultUserShell = pkgs.zsh;
    programs.zsh.enable = true;
  };



}
