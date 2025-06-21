{ lib
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) str package int;
in
{
  options.mods.theme = {
    cursor = {
      name = mkOption { type = str;};
      package = mkOption {type = package;};
      size = mkOption {type = int;};
    };
  };
}