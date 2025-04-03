let
  lib = import <nixpkgs/lib>;
in
  (import ./importer.nix) 
      { modules.enabler.enable = true;}
      lib
      ./modules
  