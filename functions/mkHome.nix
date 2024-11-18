{lib, fun, ...}: aPath: homeOptSet:
  let
    inherit (lib.attrsets) filterAttrs mapAttrs optionalAttrs;
    enableOpt = fun.aPathToEnableOpt aPath;
    hmUsers = builtins.attrNames (filterAttrs (user: user.hmUser == true) modules.users);

    forAllHMUsers = set: {
      home-manager.users = lib.genAttrs hmUsers (_: set);
    };

  in
    optionalAttrs 
      aPath.enable 
      (forAllHMUsers (homeOptSet // {inherit aPath;})) // enableOpt