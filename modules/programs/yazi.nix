{ pkgs
, config
, lib
, mkHome
, ...
} @set:
{
  environment.systemPackages = [ 
    pkgs.yazi
  ];
} // mkHome set {
  programs.yazi = {
    enable = true;
    enableZshIntegration = config.mods.shell.zsh.enable;
    enableNushellIntegration = config.mods.shell.nush.enable;
    settings = {
      manager = {
        show_hidden = true;  # always show dotfiles
      };
    };
    keymap.manager.prepend_keymap = 
      lib.mapAttrsToList (key: cmd: { on = key; run = cmd;})
      {
        "i" = "arrow prev";
        "k" = "arrow next";
        "j" = "leave";
        "l" = "enter";
        "e" = "packing extract";
        "z" = "packing compress";
        "c" = "copy";
        "x" = "cut";
        "v" = "paste";
        "m" = "select --toggle";
      };
  };
} 
