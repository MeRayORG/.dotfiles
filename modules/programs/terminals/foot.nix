{ pkgs
, mkHome
, config
, lib
, ...  
}:
let mfCfg = config.mods.theme.fonts.mono; in
{ 
  config = lib.mkIf (config.mods.programs.terminal.which == "foot") ({
    environment.systemPackages = [ pkgs.foot];
  } //
  mkHome config {
    programs.foot = {
      enable = true;
      settings = {
        main = {
          font = "${mfCfg.main}:size=${builtins.toString (mfCfg.size)}";
          pad  = "5x5";
          line-height = "${builtins.toString (mfCfg.size + 2)}";
          # "vertical-letter-offset" = "...";
        };
        cursor = {
          style = "beam";
          blink = true;
          blink-rate = 600;
          beam-thickness = 1;
        };
        text-bindings ={
          "\\x17" = "Control+BackSpace";
        };
        scrollback = {
          lines = 32000;
        };
      }; 
    };
  });
}