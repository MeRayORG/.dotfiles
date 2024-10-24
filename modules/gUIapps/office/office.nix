{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #mkif env = hyperland or Sway
    #onlyoffice-bin
    #else
    onlyoffice-bin_latest

    gimp
    inkscape
  ];
}
