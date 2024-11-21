# creates an enable option for a set and disables it based on the option

{lib, fun, ...}@inputset: aPath: setAPathFunction:
  let
    enableOpt = fun.aPathToEnableOpt aPath;
  in
    optionalAttrs 
      aPath.val.enable
      (setAPathFunction inputset aPath) // enableOpt