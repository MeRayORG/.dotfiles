#inputset:
let

  inputset = {
    lib = import <nixpkgs/lib>;
  };

in
  {
    importer = (import ./importer.nix) inputset;
  }