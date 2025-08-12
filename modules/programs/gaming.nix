{ pkgs
, ...
}:{
  mods.desktops.xway = true; # for steam :(

  environment.systemPackages = [
    pkgs.steam
  ];
}