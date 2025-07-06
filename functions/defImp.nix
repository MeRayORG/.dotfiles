{lib, ...}:

dir: name:
let
  # Filter to get all directories and .nix files except default.nix
  validNames = builtins.attrNames (
    lib.attrsets.filterAttrs
      (name: type:
        (type == "directory") ||
        (type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix")
      )

      (builtins.readDir dir)
  );
in
{
  imports = map (name: dir + "/${name}") validNames;
}
 # {aPath = aPath ++ ["${name}"];}