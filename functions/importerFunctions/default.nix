importerSet:
let

  mkImporterFun = path: (import path) importerSet;
  mkHome           = mkImporterFun ./mkHome.nix;
  mkSys            = mkImporterFun ./mkSys.nix;
  mkUser           = mkImporterFun ./mkUser.nix;
  mkShellScript    = mkImporterFun ./mkShellScript.nix;

in
  # the following get passed the location specific aPath beforehand, but accept (except SS) a custom aPath
  {inherit mkHome mkSys mkUser mkShellScript;}