inputs: dir:

let
  system = "x86_64-linux";

  pkgs  = import inputs.nixpkgs { inherit system; };
  upkgs = import inputs.upkgs   { inherit system; };
  inherit (inputs.nixpkgs) lib;

  importLooper = (import ./importLooper.nix);
  importerFunctions = import ./importerFunctions;


  importFunction = path: aPath:
  let
    set = { # set to import to each importerFunction
      inherit
        lib # for library functions 
        aPath
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