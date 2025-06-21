{ lib
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) str package;
in
{
  options.mods.theme = {
    icon = {
      name = mkOption { type = str;};
      package = mkOption {type = package;};
    };
  };
}