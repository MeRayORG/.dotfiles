{lib, ...}:

# dir -> (transformable -> shortkv) -> {k = v;}

#transformable :: {
#                   name         :: string   // filename without extension; archive.tar
#                   fNameExt     :: string   // filename with extension; archive.tar.gz
#                   ext          :: string   // extension; no leading dot; gz
#                   location     :: [string] // relative location; ["project", "out"]
#                   filepath     :: path     // the resulting filepath in nixstore; sha-project/project/out/archive.tar.gz
#                   data         :: any      // if nix then (import filepath) else (builtins.readFile filepath);
#                   nix          :: bool     // is it a nix file
#                   def          :: bool     // is it a default.nix
#                   tf           :: {}       // transformers for common operations 
#                   }
#shortkv :: {
#      k :: string // name of key
#      v :: any    // if null the key won't be included in the nestedAttrset; will loop if eval v -> error
#           }
#
#This example will map each sh script in ./scripts to it's name on the path
#      environment.systemPackages = 
#          lib.mapAttrsToList 
#               (pkgs.writeShellScriptBin)
#               (mapDir ./scripts ({tf,...}: tf.script));

dir:
transformer: 

let
    inherit (builtins) readDir readFile;
    empty = ls: ls ==[];
    join = builtins.concatStringsSep;
    split = lib.strings.splitString;
    filter = lib.filterAttrsRecursive;



    # pretransformer :: 
    # { "fileName.Ext" = ("regular" | "directory");} -> transformable
  
    pretransformer = 
      location:
      fNameExt: 
      type:
        let nameComponents = split "." fNameExt; in
      rec {
        inherit fNameExt location;
        name      = join "." (lib.init nameComponents);
        ext       = lib.last nameComponents;
        filepath  = "${dir}${if (empty location) then "" else "/"}${ join "/" location}/${fNameExt}";
        data      = if nix then (import filepath) else (readFile filepath);
        file      = type == "regular";
        directory = type == "directory";
        nix       = ext == "nix"; 
        def       = fNameExt  == "default.nix";

        tf = {
          script = {
            k = name;
            v = if ext == "sh" then ''${data}'' else null;
          };
          func = value: {
            k = name;
            v = if nix then value else null;
          };
        };
      };

    postTransformer = transformed:
          lib.nameValuePair 
                  transformed.k 
                  transformed.v;

    nullFilter = filter (_:v: v != null);

    transform = lib.mapAttrs'
                      (fn: t: 
                              (pretransformer [] fn t) |> 
                              transformer |> 
                              postTransformer);
in
    (readDir dir) |> transform |> nullFilter
