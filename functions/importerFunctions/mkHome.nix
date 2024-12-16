{
  lib, 
  fun, 
  importerAPath,
  modules,
  ...
}@importerSet:

{
  customAPath ? {}
}:

homeOptSet:
let
  aPath = importerAPath // customAPath;

  inherit (lib.attrsets) filterAttrs mapAttrs optionalAttrs;

  # filterAttrs takes (name: val: bool) arguments
  hmUsers = builtins.attrNames (filterAttrs (name: user: user.hmUser == true) modules.users);

  forAllHMUsers = set: {
    home-manager.users = lib.genAttrs hmUsers (_: set);
  };

  baseSet = forAllHMUsers (homeOptSet // { inherit aPath; });
  enableOpt = fun.aPathToEnableOpt aPath;
  finalSet = baseSet // enableOpt;
in
  optionalAttrs finalSet.enable finalSet
