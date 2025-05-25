{lib, pkgs, ... }: with lib;

{
  environment.systemPackages = with pkgs; [
    starship
    
  ];
  fonts.packages = [pkgs.nerd-fonts.fira-mono];
}
