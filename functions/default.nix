#inputset:
let

  inputset = {
    lib = import <nixpkgs/lib>;
  };

  fun   = (import ./default.nix) inputset;
  mkFun = (import ./mkFun.nix  ) inputset;

  aPathToEnableOpt = mkFun ./aPathToEnableOpt.nix;
  mkHome           = import ./mkHome.nix;
  mkSys            = import ./mkSys.nix;
  mkUser           = import ./mkUser.nix;
  importer         = mkFun ./defImporter.nix;
  mkShellScript    = import ./mkShellScript.nix;
  mkEnableFun      = mkFun ./mkEnableFun.nix;


in
  {
    inherit fun;
    inherit importer mkEnableFun;
    # the following get passed the location specific aPath beforehand, but accept (except SS) a custom aPath
    inherit mkHome mkSys mkUser mkShellScript;


  }