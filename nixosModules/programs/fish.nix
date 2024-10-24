{ config, lib, pkgs, ... }: with lib;

{
  environment.systemPackages = with pkgs; [
    fish
  ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
}
