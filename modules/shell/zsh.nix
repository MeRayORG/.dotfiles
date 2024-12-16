{ pkgs, ... }:

{
  environment.systemPackages = [
    pkgs.zsh 
  ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
}
