{ pkgs
, ...
}:{
  environment.systemPackages = with pkgs;[
    ## Office
    #mkif env = hyperland or Sway
    #onlyoffice-bin
    #else
    onlyoffice-bin_latest
    drawio
    teams-for-linux

    obsidian 
  ];
}