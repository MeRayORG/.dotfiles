{
  lib,
  config,
  ...
  }:
{
  options.mods.xway = lib.mkEnableOption "xwayland.";
  config =  {
    environment = lib.mkIf (! config.services.xserver.enable) {
      sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Enable wayland for chromium-based apps (VSCode Discord Brave)
      };
    };
  };

}