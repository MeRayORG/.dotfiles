{lib, ...}: dir: importFunction:
  let

    inherit (builtins) attrNames readDir readFileType isPath baseNameOf toString;
    inherit (lib.strings) hasSuffix removeSuffix;
    inherit (lib.filesystem) pathIsDirectory;


    itemParser = importFunction: {fileODirName, oldPath, oldAPath}:
      let
        path = lib.path.append oldPath fileODirName;

        isDir = pathIsDirectory path;
        isNix = hasSuffix ".nix" (toString path);
        isDef = fileODirName == "default.nix";

        parseNix = 
          let
            name = removeSuffix ".nix" fileODirName;
            #updateSet
            aPath = oldAPath ++ [name];
          in
            importFunction path aPath;

        parseDef = importFunction path oldAPath;

        doLoop = 
          let
            name = fileODirName;
            #updateSet
            aPath = oldAPath ++ [name];
          in
            builtins.foldl'
              ( set: item:
                lib.recursiveUpdate # https://nix.dev/guides/best-practices.html#updating-nested-attribute-sets
                  (itemParser importFunction { 
                    fileODirName = item;
                    oldPath = path;
                    oldAPath = aPath; 
                  })
                  set
              ) 
              {} 
              (attrNames (readDir path))
            ;
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