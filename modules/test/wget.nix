{
  pkgs,
  mkEnable,
  ...
}:

mkEnable {
  environment.systemPackages = [
    pkgs.wget
  ];
}