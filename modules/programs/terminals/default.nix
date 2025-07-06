{ defImp
, lib
, config
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) enum;
in
  defImp ./. "terminal" // {
    options.mods.programs.terminal.which = mkOption {
        type = enum ["foot" "kitty" "ghostty"];
      };
    config = {
      environment.sessionVariables = {
        "TERM" = config.mods.programs.terminal.which;
      };
    };
  }

