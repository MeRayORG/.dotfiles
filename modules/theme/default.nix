{ defImp
, lib
, config
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) enum str derivation;
in
  defImp set ./. "theme" // {/*
    options.mods.theme = {
      colors = {
        name = mkOption { type = str;};
        package = mkOption {type = derivation;};
      };
      cursor = {
        name = mkOption { type = str;};
        package = mkOption {type = derivation;};
      };
      icon = {
        name = mkOption { type = str;};
        package = mkOption {type = derivation;};
      };
    };
     */
  }
