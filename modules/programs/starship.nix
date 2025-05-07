{lib, pkgs, ... }: with lib;

{
  environment.systemPackages = with pkgs; [
    starship
    
  ];
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
  ];
}
