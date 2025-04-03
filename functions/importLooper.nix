lib:
path:
importFunction:

let
  # Recursively traverse the directory and collect .nix files
  importModules = dir: basePath:
    let
      contents = builtins.readDir dir;
      processEntry = fileName: type:
        if type == "directory" then
          importModules (dir + "/${fileName}") (basePath ++ [fileName])
        else if type == "regular" && lib.strings.hasSuffix ".nix" fileName then
          let
            name = lib.strings.removeSuffix ".nix" fileName;
            # Compute the relative path as a list (e.g., ["patches" "fix"])
            aPath = basePath ++ [name];
            # Import the module as a function, passing the path as an argument
          in
            [(importFunction (dir + "/${fileName}") aPath)]
        else
          [];
    in
      builtins.concatLists (builtins.attrValues (builtins.mapAttrs processEntry contents));


  # Import all modules and pass their paths as lists
  moduleslist = importModules path ["modules"];

  # Merge all modules into a single top-level set
  #mergedModules = builtins.foldl' (acc: module: acc // module) {} modules;

  mergedModules = lib.evalModules {modules = moduleslist;};

in  mergedModules
