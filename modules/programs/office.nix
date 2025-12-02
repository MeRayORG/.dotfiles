{ pkgs
, ...
}:{
  environment.systemPackages = with pkgs;[
    ## Office
    #mkif env = hyperland or Sway
    #onlyoffice-bin
    #else
    onlyoffice-desktopeditors
    drawio
    teams-for-linux

    obsidian 
  ];
}