{lib, ...}:

dir:

recurse:

transformer: 
 

let
  pretransformer = 
    location:
    fNameExt: 
    type:
      let nameComponents = lib.strings.splitString "." fNameExt; in
    rec {
      inherit fNameExt location;
      name      = builtins.concatStringsSep "." (lib.init nameComponents);
      ext       = lib.last nameComponents;
      filepath  = dir + (builtins.concatStringsSep "/" location) + "/"+ fNameExt;
      set       = import filepath;
      file      = type == "regular";
      directory = type == "directory";
      isNix     = ext == "nix"; 
      isDefault = fNameExt  == "default.nix";
    };

    postTransformer = transformed:
          lib.nameValuePair 
                  transformed.n 
                  transformed.v;

    nullFilter = set: lib.filterAttrsRecursive (_:v: v != null);

    transform = lib.mapAttrs' (fn: t: (pretransformer [] fn t) |> transformer |> postTransformer);


    # recursor = 
    #   accumulatedLocation: 
    #   path:
    #     let 
    #       accumulatedLocation
    #     in

    
      
in
    (lib.readDir dir) |> transform |> nullFilter


# nullFilter (if !recurse 
#             then transform (lib.readDir dir) 
#             else lib.splitAttrs) 


# mapDir :: 
# dir -> ({
#          filename  :: string
#          fNameExt  :: string
#          extension :: string   // no leading dot
#          location  :: [string] // relative location
#          filepath  :: path
#          set       :: any      // the imported file
#          isNix     :: bool
#          isDefault :: bool 
#          } -> {
#                k    :: string // name of key; defaults to filename 
#                v    :: any    // if null the key won't be included in the nestedAttrset
#                })
#                   -> {}
#
# readDir :: Path -> { "fileName.Ext" = ("regular" | "directory"); }
#
# pretransformer :: 
# {"fileName.Ext" = ("regular" | "directory");} -> {
#                                                   filename  :: string
#                                                   extension :: string   // no leading dot
#                                                   location  :: [string] // relative location
#                                                   filepath  :: path
#                                                   import    :: {}       // only if isNix
#                                                   isNix     :: bool
#                                                   isDefault :: bool 
#                                                   }
