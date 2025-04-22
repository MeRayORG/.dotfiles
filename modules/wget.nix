{
  pkgs,
  config,
  mkEnable,
  ...
}:
  mkEnable config ["wget"] {
    environment.systemPackages = [pkgs.wget];
  }


