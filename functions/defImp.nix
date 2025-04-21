{
  lib,
  ...
}:
{
  aPath,
  name,
  config ? {},
  options ? {}
}:
let
  # Filter to get all directories and .nix files except default.nix
  validNames = builtins.attrNames (
    lib.attrsets.filterAttrs
      (name: type:
        (type == "directory") ||
        (type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix")
      )

      (builtins.readDir ./.)
  );
in
{
  imports = map (name: ./. + "/${name}") validNames;
  specialArgs = {
    aPath = aPath ++ ["${name}"];
  };
  inherit config options;
}