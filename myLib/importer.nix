dir: importFunction: lib:
  let

    inherit (builtins) attrNames readDir readFileType isPath baseNameOf toString concatStringsSep;
    inherit (lib.strings) hasSuffix removeSuffix;

    itemParser = importFunction: {fileODirName, oldPath, oldAPath}:
      let
        path = oldPath + "/${fileODirName}";

        isDir = (readFileType path) == "directory";
        isNix = hasSuffix ".nix" (toString path);
        isDef = fileODirName == "default.nix";

        parseNix = 
          let
            name = removeSuffix ".nix" fileODirName;
            #updateSet
            aPath = oldAPath ++ [name];
          in
            importFunction path aPath;

        parseDef = importFunction path oldAPath; # "path: ${path} aPath: ${aPath} @deffile"; 

        doLoop = 
          let
            name = fileODirName;
            #updateSet
            aPath = oldAPath ++ [name];
          in
            map (item:
                itemParser importFunction { 
                  fileODirName = item;
                  oldPath = path;
                  oldAPath = aPath; 
                }
              ) (attrNames (readDir path));
      in
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
        );
  in
    if !(isPath dir) 
    then throw "importer needs a nix path"
    else (
      itemParser importFunction { fileODirName = baseNameOf dir; oldPath = ./.; oldAPath = [];}
    )

# (import ./importer.nix) ./modules (path: aPath: import path ({a = 2;} // {inherit aPath;})) (import <nixpkgs/lib>)
# (import ./importer.nix) ./modules (path: aPath: import path {a = 2;}) (import <nixpkgs/lib>)
# a pathlist to attrset concatStringsSep