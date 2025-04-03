config: lib: dir:

let

  # pkgs  = import inputs.nixpkgs {inherit (configuration) system;};
  # upkgs = import inputs.upkgs   {inherit (configuration) system;};
  # inherit (inputs.nixpkgs) lib;

  importLooper = (import ./importLooper.nix);
  importerFunctions = import ./importerFunctions;


  importFunction = path: aPath:
  let
    set = { # set to import to each importerFunction
      inherit
        lib # for library functions 
        aPath
        config
        ;
    };
    
  in
    import path (
      (importerFunctions set) // set
    );
in
  importLooper lib dir importFunction