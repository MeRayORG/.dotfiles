{lib, ...}@inputset: dir:

let
  importer = (import ./importLooper.nix) inputset;


  importFunction = path: importerPath:
    import path ({
      importerAPath = mkAPath importerPath;
      

      inherit (inputset.fun) mkSys mkHome mkUser;
    } // inputset);
in
  importer dir importFunction