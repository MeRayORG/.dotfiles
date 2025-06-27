{ pkgs
, config
, lib
, ...
}: 
let 
inherit (lib) hasAttr setAttrbypath;
cfg = config.mods.theme; 
in
{
  config = {
    #https://nix-community.github.io/stylix/configuration.html

    # If stylix.base16Scheme is undeclared, Stylix generates a color scheme based on the wallpaper using a genetic algorithm.

    # stylix = { 
    #   #rest of stylix config
    #   enable = true;
    #   targets = {
    #     hyprland.enable = false;
    #     #hyprpaper.enable = false;
    #   };
      
    # };
    # // (if (hasAttr "colors" cfg) then (setAttrbypath ["base16scheme"] cfg.colors) else {});
  };
}