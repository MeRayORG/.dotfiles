dir: importFunction: lib:
  let

    inherit (builtins) attrNames readDir readFileType isPath baseNameOf toString;
    inherit (lib.strings) hasSuffix removeSuffix;

    itemParser = importFunction: {fileODirName, oldPath, oldAttrs}:
      let
        path = oldPath + "/${fileODirName}";

        isDir = (readFileType path) == "directory";
        isNix = hasSuffix (toString path) ".nix";
        isDef = fileODirName == "default.nix";

        parseNix = 
          let
            name = removeSuffix ".nix" fileODirName;
            #updateSet
            attrs = oldAttrs.name;
          in
            importFunction path attrs;

        parseDef = importFunction path oldAttrs;

        doLoop = 
          let
            name = fileODirName;
            #updateSet
            attrs = oldAttrs.name;
          in
            map (item:
                itemParser importFunction { 
                  fileODirName = item;
                  oldPath = path;
                  oldAttrs = attrs; 
                }
              ) (attrNames (readDir path));
      in
        if !(isPath dir) 
        then throw "importer needs a nix path"
        else (
          if isDir
          then doLoop
          else (
            if isDef
            then parseDef
            else (
              if isNix
              then parseNix
              else {}
            )
          )
        );
  in
    itemParser importFunction { fileODirName = baseNameOf dir; oldPath = ./.; oldAttrs = {};}

# (import ./importer.nix) ./modules (path: attrs: import path ({a = 2;} // {inherit attrs;})) (import <nixpkgs/lib>) 