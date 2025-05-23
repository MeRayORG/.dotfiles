{
  nixos-cosmic, 
  ...
}:
{
  imports = [nixos-cosmic.nixosModules.default];
  config = {
    services = {
      xserver.enable = false;
      desktopManager.cosmic.enable = true;
      displayManager.cosmic-greeter.enable = true;
    };
    nixpkgs.overlays = [
      (final: prev: {
        cosmic-comp = prev.cosmic-comp.override {
          useXWayland = false;
        };
      })
    ];
    nix.settings = {
      substituters = [ "https://cosmic.cachix.org/" ];
      trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
    };
  };
}