{ mkHome
, pkgs
, config
, ...
}:
{
  # environment.sessionVariables = {
  #     QT_QPA_PLATFORMTHEME = "qt5ct";   # used by Qt5
  #     QT_QPA_PLATFORMTHEME_QT6 = "qt6ct"; # used by Qt6
  #   };
} //
mkHome config {
  home.packages = [
    pkgs.libsForQt5.qt5ct
    pkgs.qt6ct
  ];
}