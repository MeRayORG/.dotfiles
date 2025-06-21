{ mkHome
, pkgs
, ...
} @set:
mkHome set {
  

  
  home = {
    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";   # used by Qt5
      QT_QPA_PLATFORMTHEME_QT6 = "qt6ct"; # used by Qt6
    };
    packages = [
      pkgs.libsForQt5.qt5ct
      pkgs.qt6ct
    ];
  };

    
}