{fun, ...}: aPath: set:
  let
    enableOpt = fun.aPathToEnableOpt aPath;
  in
    optionalAttrs 
      aPath.enable 
      set // {inherit aPath;} // enableOpt