let
  lib = import <nixpkgs/lib>;
in
  (import ./importLooper.nix) 
      lib
      ./mo
      (
        path: aPath:
        (import path) aPath
      )
  