{ lib
, config
, ... 
}:
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
  config.environment.systemPackages = [ config.mods.theme.cursor.package ];
}