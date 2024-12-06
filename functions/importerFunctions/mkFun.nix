{
  lib,
 ... 
}@importerset:
path:

let
  fun = rec{

    # creates an enable option for a set and disables it based on the option
    mkEnableFun =
      aPath: 
      setAPathFunction:
        let
          enableOpt = aPathToEnableOpt aPath;
        in
          lib.optionalAttrs 
            aPath.readEnable
            (setAPathFunction importerset aPath) // enableOpt;

    # Creates enableoption out of an aPath
    aPathToEnableOpt = 
    aPath:
      aPath.setVal
        "enable"
        (lib.mkEnableOption {
          # name = "enable";
          description = "Whether to enable ${aPath.last}";
        });

    


  };


in
  (import path) importerSet // {inherit fun;}