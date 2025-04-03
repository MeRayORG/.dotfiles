let
  lib = import <nixpkgs/lib>;
  funs = (import ./importerFunctions) {
    inherit lib;
    aPath = ["modules"];
    config = { modules.enable = false;};
  };
in
  ((import ./modules/enabler.nix) funs)