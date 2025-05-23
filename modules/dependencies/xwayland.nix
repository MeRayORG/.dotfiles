{
  lib,
  config,
  ...
  }:
{
  options.mods.x = lib.mkEnableOption "the xserver.";
  config =  {
    services.xserver.enable = if config.mods.x then true else false;

    environment = lib.mkIf (! config.mods.x) {
      sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Enable wayland for chromium-based apps (VSCode Discord Brave)
      };
    };
  };

}