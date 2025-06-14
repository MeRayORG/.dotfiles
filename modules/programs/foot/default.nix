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
        pad  = "5x5";
        line-height = "${builtins.toString (config.mods.fonts.mono.size + 2)}";
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
      # key-bindings = {

      #   copy  = "Control+Shift+c";
      #   paste = "Control+Shift+v";
      # };
      # search-bindings = {
      #   cursor-right-word = "Control+Right";
      #   cursor-left-word  = "Control+Left";
      #   # doesnt work for some goddamn reason
      #   delete-prev-word  = "Control+BackSpace";
      #   delete-next-word  = "Control+Delete";
      #   extend-to-word-boundary = "Control+Shift+Right";
      #   extend-backward-to-word-boundary = "Control+Shift+Left";
      #   extend-line-up = "Shift+Up"; 
      #   extend-line-down = "Shift+Down";
      # };
    }; 
  };
}