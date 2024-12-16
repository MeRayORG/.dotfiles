inputs: dir:

let
  configuration = import ../hosts/raytop/normal.nix;

  pkgs  = import inputs.nixpkgs {inherit (configuration) system;};
  upkgs = import inputs.upkgs   {inherit (configuration) system;};
  inherit (pkgs) lib;

  importLooper = (import ./importLooper.nix) lib;

  sets = aPath: 
  let
    cfg = lib.attrsets.attrByPath aPath {} configuration.mods;

  in {
    forFunc = { # set to import to each importerFunction
      inherit
        lib # for library functions 
        cfg # check in mkSysFunc if modules.programs.firefox.enable = true
        inputs # get HomeManager in mkHome
        ;
    };


    forMods = { # set to import to each module
      inherit lib inputs pkgs upkgs cfg;
    };
  };




  importFunction = path: aPath:
  let
    setForMods = (sets aPath).forMods;
    setForFunc = (sets aPath).forFunc;

  in
    import path (
      setForMods
      ((import ./importerFunctions) setForFunc)  
    );

  modules = importLooper dir importFunction;
in
  modules