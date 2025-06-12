{ lib, ... }@set:

let
  # Only get non-default .nix files
  nixFiles = lib.filter (f: lib.hasSuffix ".nix" f && f != "default.nix")
    (lib.attrNames (builtins.readDir ./.));

  # Strip .nix extension for the attr name
  toName = file: lib.removeSuffix ".nix" file;

  # Import each file and call it with our set
  eval = file: (import ./${file}) set;
in
  lib.listToAttrs (map (file: {
    name = toName file;
    value = eval file;
  }) nixFiles)