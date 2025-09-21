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
      filename  = builtins.concatStringsSep "." (lib.init nameComponents);
      extension = lib.last nameComponents;
      filepath  = dir + (builtins.concatStringsSep "." location) + "/"+ fNameExt;
      set       = import filepath;
      file      = type == "regular";
      directory = type == "directory";
      isNix     = extension == "nix"; 
      isDefault = fNameExt  == "default.nix";
    };

    postTransformer =
      transformed:
      let inherit (transformed) name value; in 
      lib.nameValuePair name value;

    nullFilter = set: lib.filterAttrsRecursive (_:value: value != null);

    transform = set: lib.mapAttrs' (postTransformer . transformer . pretransformer []);

    
      
in

nullFilter (if !recurse then transform (lib.readDir dir) else lib.splitAttrs) 


# mapDir :: 
# dir -> ({
#          filename  :: string
#          fNameExt  :: string
#          extension :: string   // no leading dot
#          location  :: [string] // relative location
#          filepath  :: path
#          nix       :: {}       // only if isNix
#          isNix     :: bool
#          isDefault :: bool 
#          } -> {
#                name     :: string // name of key; defaults to filename 
#                value    :: any    // if null the key won't be included in the nestedAttrset
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
