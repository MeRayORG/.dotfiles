{lib, ...}@inputset: dir:

let

  inherit (lib.attrsets) setAttrByPath hasAttrByPath;
  importLooper = (import ./importLooper.nix) inputset;

  mkAPath = list:
    {
      inherit list;
      last = lib.lists.last list;
      setVal = setAttrByPath list;
      readAttr = attr: defval: hasAttrByPath (list ++ [attr]) defval modules; 
      readEnable = hasAttrByPath (list ++ ["enable"]) false modules; 


      #addOption = # eg. mkHome {...} |> addOption 
    # optionPath =
    # configPath = 
    };


  importFunction = path: importerPath:
    let
      importerAPath = mkAPath importerPath;
    in 
    import path (
      {
        inherit importerAPath modules mkAPath;
      } 
      // inputset // 
      ((import ./importerFunctions) inputset//{inherit importerAPath modules mkAPath;})  
    );

  modules = importLooper dir importFunction;
in
  modules