{ pkgs
, ...
}:{
  mods.desktops.xway = true; # for steam :(

  environment.systemPackages = [
    pkgs.nexusmods-app # modmanager for cyberpunk
    pkgs.steam
  ];
}