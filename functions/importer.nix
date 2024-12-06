{fun, ...}@inputset: dir:

let
  importLooper = (import ./importLooper.nix) inputset;


  importFunction = path: importerPath:
    let
      importerAPath = fun.mkAPath importerPath;
    in 
    import path (
      {
        inherit importerAPath modules;
      } 
      // inputset // 
      ((import ./importerFunctions) inputset//{inherit importerAPath modules;})  
    );

  modules = importLooper dir importFunction;
in
  modules