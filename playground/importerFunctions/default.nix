{
  lib,
  ...
}@setForFunctions:

let
  files = builtins.attrNames (builtins.readDir ./.);
  nixFiles = builtins.filter (file:
    file != "default.nix" && lib.strings.hasSuffix ".nix" file
  ) files;
in
  builtins.listToAttrs (map (file: {
    name = lib.strings.removeSuffix ".nix" file;
    value = import (./. + "/${file}") setForFunctions;
  }) nixFiles)