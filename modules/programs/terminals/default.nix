{ defImp
, lib
, config
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) enum;
in
  defImp set ./. "terminal" // {
    options.mods.programs.terminal.which = {
      de = mkOption {
        type = enum ["foot" "kitty"];
      };
    };
  }

