{ config, lib, pkgs, ... }: with lib;

{

environment.systemPackages = with pkgs; [
  libsecret
  gitFull
];

programs.git = {
  enable = true;


};
}
