{
  pkgs,
  mkEnable,
  ...
}@set:
  mkEnable set ["wget"] {
    environment.systemPackages = [pkgs.wget];
  }


