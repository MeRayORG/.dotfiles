{lib, ...}@inputset: dir:

let
  importer = (import ./importLooper.nix) inputset;
  inherit (lib.attrsets) setAttrByPath;

  importFunction = path: aPath:
    import path ({
      inherit aPath;
      apath = rec {
        list = aPath;
        setVal = value: setAttrByPath list;
      # optionPath =
      # configPath = 
      };

      inherit (inputset.fun) mkSys mkHome mkUser;
      
      # optionPath =
      # configPath = 
    } // inputset);
in
  importer dir importFunction