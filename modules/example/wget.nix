{ config
, pkgs
, mkEnable
, ...
}:
  mkEnable config ["wget"] {
    environment.systemPackages = [pkgs.wget];
  }


