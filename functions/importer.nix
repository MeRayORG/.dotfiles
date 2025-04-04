inputs: dir: config:

let

  pkgs  = import inputs.nixpkgs { system = config.systemArchitecture; };
  upkgs = import inputs.upkgs   { system = config.systemArchitecture; };
  inherit (inputs.nixpkgs) lib;

  importLooper = (import ./importLooper.nix);
  importerFunctions = import ./importerFunctions;


  importFunction = path: aPath:
  let
    set = { # set to import to each importerFunction
      inherit
        lib # for library functions 
        aPath
        config
        pkgs
        upkgs
        ;
    };
    
  in
    import path (
      (importerFunctions set) // set
    );
in
  importLooper lib dir importFunction