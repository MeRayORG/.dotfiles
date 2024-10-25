{
  inputs,
  ...
}: let
	pkgs = inputs.nixpkgs;
in {
  pkgs.overlay = inputs.hyprpanel.overlay;
  environment.systemPackages = [pkgs.hyprpanel pkgs.cowsay];
}
