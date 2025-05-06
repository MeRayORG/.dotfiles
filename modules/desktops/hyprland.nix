{
  hyprland,
  pkgs,
  ...
}: 
{
  programs = {
    # HYPRLAND
    hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.hyprland;
    };
    # HYPRLOCK
    hyprlock.enable = true;
  };

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   plugins = [
  #     #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
  #     # ...
  #   ];
  # };
}