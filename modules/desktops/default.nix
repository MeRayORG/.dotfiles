{ defImp
, lib
, config
, ... 
}:
let 
  inherit (lib) mkOption;
  inherit (lib.types) enum;


in
  defImp ./. "desktops" // {
    options.mods.desktops = {
      de = mkOption {
        type = enum ["hypr" "cosmic" "gnome" "kde" "hyde" "none"];
      };
      xway = lib.mkEnableOption "xwayland.";
    };
    config =  {
      environment = lib.mkIf (! config.services.xserver.enable) {
        sessionVariables = {
          NIXOS_OZONE_WL = "1"; # Enable wayland for chromium-based apps (VSCode Discord Brave)
        };
      };
    };
  }

