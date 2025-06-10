{ config
, lib
, ...
}:
let cfg = config.mods.desktops; in 
{ 
  config = lib.mkIf (cfg.de == "hyde") {
    services = {
      desktopManager.cosmic = {
        enable = true;
        xwayland.enable = cfg.xway; # for steam :(
      };
      displayManager.cosmic-greeter.enable = true;
    };
    nix.settings = {
      substituters = [ "https://cosmic.cachix.org/" ];
      trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
    };
  };
}