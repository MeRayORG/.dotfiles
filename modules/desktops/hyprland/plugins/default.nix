{ getDir
, mkHome
, lib
, pkgs
, ...
} @set:
mkHome set {
  wayland.windowManager.hyprland.plugins = 

    map ({imported,...}: imported set) (
    lib.lists.filter ({isNix,...}: isNix)
    
    (getDir set ./. {}));
}

