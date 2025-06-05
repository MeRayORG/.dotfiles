{ defImp
, lib
, config
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) enum;


in
  defImp set ./. "desktops" // {
    options.mods.desktops = {
      de = mkOption {
        type = enum ["hyprland" "cosmic" "kde" "none"];
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

