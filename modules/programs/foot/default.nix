{ pkgs
, mkHome
, config
, ...  
}@set:
{
  environment.systemPackages = [ pkgs.foot];
} //
mkHome set {
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "${config.mods.fonts.mono.main}:size=${builtins.toString (config.mods.fonts.mono.size)}";
        pad  = "3x3";
        line-height = "${builtins.toString (config.mods.fonts.mono.size + 2)}";
        # "vertical-letter-offset" = "...";
        cursor-shape = "beam";
        cursor-blink = true;
      };
      bindings = {
        copy = "Control+Shift+c";
        paste = "Control+Shift+v";
      };
    }; 
  };
}