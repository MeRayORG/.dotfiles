{
  lib, 
  fun, 
  importerAPath, 
  ...
}@importerSet:
{
  customAPath ? {}
}:

set:
let
  aPath = importerAPath // customAPath;
  enableOpt = fun.aPathToEnableOpt aPath;
  finalSet = set // { inherit aPath; } // enableOpt;
in
  lib.optionalAttrs finalSet.enable finalSet
