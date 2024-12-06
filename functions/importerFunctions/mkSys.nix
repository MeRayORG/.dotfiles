{
  lib, 
  fun, 
  importerAPath, 
  ...
}@importerSet:
# the first set is made via the importer to pass lib, fun, nixpkgs,... and the importerAPath
# the second accepted set are basically the options for the function
{
  customAPath ? {} 
}:

set:
  let
    aPath = importerAPath // customAPath;
    enableOpt = fun.aPathToEnableOpt aPath;
  in
    lib.optionalAttrs 
      aPath.enable 
      set // {inherit aPath;} // enableOpt