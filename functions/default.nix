#inputset:
let

  inputset = {
    lib = import <nixpkgs/lib>;
  };

  fun   = (import ./default.nix) inputset;
  mkFun = (import ./mkFun.nix  ) inputset//{ inherit fun;};

  aPathToEnableOpt = mkFun ./aPathToEnableOpt.nix;
  importer         = mkFun ./defImporter.nix;
  mkEnableFun      = mkFun ./mkEnableFun.nix;

in
  {
    inherit importer mkEnableFun aPathToEnableOpt;
  }