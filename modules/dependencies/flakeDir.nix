{
  lib,
  ...
  }:
{
  options.mods.flakeDir = lib.mkOption {
          description = "Location of the nix flake(user must have R)";
          type = lib.types.str;
        };
}