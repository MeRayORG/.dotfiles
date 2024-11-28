{lib, fun, ...}@inputset: dir:

let
  importer = (import ./importLooper.nix) inputset;


  importFunction = path: importerPath:
    import path ({
      importerAPath = fun.mkAPath importerPath;
    } 
    // inputset // 
    ((import ./importerFunctions) inputset//{importerAPath})  
    );
in
  importer dir importFunction