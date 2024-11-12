inputset: dir:
  let
    path = dir;
    itemParser = inputset: {fileODirName, oldPath, oldAttrs}:
      let
        #sanitizename
        name = fileODirName - ".nix";
        #updatePath
        currentPath = "${path}/${fileODirName}";

        #updateSet
        attrs =
          if   name == "default.nix"
          then oldAttrs
          else oldAttrs.name;
        importFile = import path (inputset // {attrs});
      in
        if   isDir path
        then map (name: itemParser inputset {name = fileODirName; oldPath = path; attrs = oldAttrs; })
        else (
          if   isNixFile path
          then importFile
          else {}
        );
  in itemParser inputset {fileODirName = dir; oldPath = ""; oldAttrs = {};}


