{
  pkgs,
  mkEnable,
  aPath,
  ...
}:

mkEnable (aPath ++ ["wget"]) {
  environment.systemPackages = [
    pkgs.wget
  ];
}