{
  lib, 
  fun, 
  importerAPath, 
  ...
}:

{
  customAPath ? {} 
}:

homeOptSet:


  let
    aPath = importerAPath // customAPath;

    inherit (lib.attrsets) filterAttrs mapAttrs optionalAttrs;

    enableOpt = fun.aPathToEnableOpt aPath;
    hmUsers = builtins.attrNames (filterAttrs (user: user.hmUser == true) modules.users);

    forAllHMUsers = set: {
      home-manager.users = lib.genAttrs hmUsers (_: set);
    };

  in
    optionalAttrs 
      aPath.setVal
        "enable"
        (forAllHMUsers (homeOptSet // {inherit aPath;})) // enableOpt