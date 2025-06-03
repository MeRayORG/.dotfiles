{ defImp
, lib
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) enum;


in
  defImp set ./. "desktops" // {
    options.mods.desktops.de = mkOption {
      type = enum ["hyprland" "cosmic" "kde" "none"];

    };
  }

