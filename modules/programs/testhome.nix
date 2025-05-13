set @ {
  pkgs,
  mkHome,
  lib,
  ...
}:
mkHome set {
  home.packages = [pkgs.hello];
}