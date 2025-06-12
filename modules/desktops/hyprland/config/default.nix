{ lib
, ...  
}@set:
let
  filter = file: lib.hasSuffix ".nix" file && file != "default.nix";
  files = lib.attrNames (builtins.readDir ./.);
  nixFiles = lib.filter filter files;
  toName = file: lib.removeSuffix ".nix" file;
in
  lib.listToAttrs (map (file: {
    name = toName file;
    value = (import ./. + "/${file}") set;
  }) nixFiles)