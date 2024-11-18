{lib, ...}@inputset: dir:

let
  importer = (import ./importLooper.nix) inputset;

  importFunction = path: aPath:
    import path ({
      inherit aPath;
      inherit (inputset.fun) mkSys mkHome mkUser;
      
      optionPath =
      configPath = 
    } // inputset);
in
  importer dir importFunction