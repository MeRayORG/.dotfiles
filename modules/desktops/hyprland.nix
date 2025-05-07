{
  pkgs,
  ...
}: 
{
  fonts.packages = with pkgs; [ nerdfonts ];
  programs = {
    # HYPRLAND
    hyprland = {
      enable = true;
    };
    # HYPRLOCK
    hyprlock.enable = true;
  };
  services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
  };
  environment.systemPackages = [ pkgs.hyprpanel pkgs.foot ];

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   plugins = [
  #     #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
  #     # ...
  #   ];
  # };
}
