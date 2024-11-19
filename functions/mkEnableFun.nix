{lib, fun, ...}@inputset: aPath: setAPathFunction:
  let
    enableOpt = fun.aPathToEnableOpt aPath;
  in
    optionalAttrs 
      aPath.enable 
      (setAPathFunction inputset aPath) // enableOpt