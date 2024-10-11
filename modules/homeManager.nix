{config, pkgs, ...}:

{

  environment.systempkgs = with pkgs; [
    home-manager
  ]
}
