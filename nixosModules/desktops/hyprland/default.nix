{
  inputs,
  pkgs,
  ...
}: let 
  pkgs.overlays = [inputs.hyprpanel.overlay];
in {
  
  environment.systemPackages = [pkgs.hyprpanel pkgs.cowsay];
}
