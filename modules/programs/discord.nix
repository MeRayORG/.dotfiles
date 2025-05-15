{
  pkgs,
  ...
}:{
  environment.systemPackages = [
    #pkgs.discord
    pkgs.betterdiscordctl
    pkgs.vesktop
    pkgs.cowsay
  ];
}