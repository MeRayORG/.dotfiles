lib:
path:
importFunction:

let
  # Recursively traverse the directory and collect .nix files
  importModules = dir: basePath:
    let
      contents = builtins.readDir dir;
      processEntry = name: type:
        if type == "directory" then
          importModules (dir + "/${name}") (basePath ++ [name])
        else if type == "regular" && lib.strings.hasSuffix ".nix" name then
          let
            # Compute the relative path as a list (e.g., ["patches" "fix"])
            aPath = basePath ++ [lib.strings.removeSuffix ".nix" name];
            # Import the module as a function, passing the path as an argument
            module = importFunction (dir + "/${name}") aPath;
          in
            [ module ]
        else
          [];
    in
      builtins.concatLists (builtins.attrValues (builtins.mapAttrs processEntry contents));


  # Import all modules and pass their paths as lists
  modules = importModules path [];

  # Merge all modules into a single top-level set
  mergedModules = builtins.foldl' (acc: module: acc // module) {} modules;

in {
  inherit mergedModules;
}
