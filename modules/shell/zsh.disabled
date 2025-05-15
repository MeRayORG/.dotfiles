{ config, lib, pkgs, ... }: with lib;

{
  environment.systemPackages = with pkgs; [
    zsh 
  ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
