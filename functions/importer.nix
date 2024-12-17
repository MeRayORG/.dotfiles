{ lib, ... } @ inputset: dir:

let
  inherit (lib.attrsets) setAttrByPath hasAttrByPath;
  importLooper = (import ./importLooper.nix) inputset;

  # mkAPath is kept simple and does not reference 'modules'
  mkAPath = list: {
    inherit list;
    last = lib.lists.last list;
    setVal = setAttrByPath list;
    # No references to 'modules' or 'readAttr/readEnable' here
  };

  # importFunction no longer references 'modules' directly.
  # It imports importerFunctions after merging with inputset and importerAPath.
  importFunction = path: importerPath:
    let
      importerAPath = mkAPath importerPath;
    in
    import path (
      {
        inherit importerAPath mkAPath;
      }
      // inputset
      # Merge with importerFunctions:
      ((import ./importerFunctions) inputset // { inherit importerAPath mkAPath; })
    );

  # Define modules after importFunction is defined, to avoid forward references.
  modules = importLooper dir importFunction;

in
  modules
