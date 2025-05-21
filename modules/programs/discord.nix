{
  pkgs,
  ...
}:{
  environment.systemPackages = [
    pkgs.betterdiscordctl
    pkgs.vesktop
  ];
}