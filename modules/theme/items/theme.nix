{ lib
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) str package int;
in
{
  options.mods.theme = {
    theme = {
      gtk = {
        name = mkOption { type = str;};
        package = mkOption {type = package;};
      };
      /*
      qt = {
        name = mkOption { type = str;};
        package = mkOption {type = package;};
      };
      */

    };
  };
}