#inputset:
let

  inputset = {
    lib = import <nixpkgs/lib>;
  };

in
rec {
  fun = (import ./default.nix) inputset;
  mkFun = path: (import path) ({inherit fun;} // inputset);

  aPathToEnableOpt = mkFun ./aPathToEnableOpt.nix;
  mkHome           = mkFun ./mkHome.nix;
  mkSys            = mkFun ./mkSys.nix;
  mkUser           = mkFun ./mkUser.nix;
  importer         = mkFun ./defImporter.nix
}