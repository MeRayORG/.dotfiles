inputs: dir:

let
  configuration = import ../hosts/raytop/normal.nix;

  pkgs  = import inputs.nixpkgs {inherit (configuration) system;};
  upkgs = import inputs.upkgs   {inherit (configuration) system;};
  inherit (inputs.nixpkgs) lib;

  importLooper = (import ./importLooper.nix);
  importerFunctions = import ./importerFunctions;




  sets = aPath: 
  let
    config = configuration.mods;
    cfg = lib.attrsets.attrByPath aPath {} config;
  in {
    forFunctions = { # set to import to each importerFunction
      inherit
        lib # for library functions 
        cfg # check in mkSysFunc if modules.programs.firefox.enable = true
        inputs # get HomeManager in mkHomes
        aPath
        ;
    };
    forModules = { # set to import to each module
      inherit 
        lib 
        inputs 
        pkgs 
        upkgs 
        cfg 
        config
        aPath
        
        ;
    };
  };




  importFunction = path: aPath:
  let
    setForModules   = (sets aPath).forModules;
    setForFunctions = (sets aPath).forFunctions;

  in
    import path (
      ((import ./importerFunctions) setForFunctions)  
    );
in
  importLooper dir importFunction