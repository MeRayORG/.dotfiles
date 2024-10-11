let
  pkgs = import <nixpkgs> {};
  haumea = pkgs.haumea;
in
haumea.lib.load {
  src = ./modules;
  inputs = {
    inherit (pkgs) lib;
  };
}
