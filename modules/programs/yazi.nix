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
} // mkHome config {
  programs.yazi = {
    enable = true;
    enableZshIntegration = config.mods.shell.zsh.enable;
    enableNushellIntegration = config.mods.shell.nush.enable;
    shellWrapperName  = "y";
    settings = {
      mgr = {
        show_hidden = true;  # always show dotfiles
      };
    };
    keymap.mgr.prepend_keymap = 
      lib.mapAttrsToList (key: cmd: { on = key; run = cmd;})
      {
        "i" = "arrow prev";
        "k" = "arrow next";
        "j" = "leave";
        "l" = "enter";
        "e" = "packing extract";
        "z" = "packing compress";
        "c" = "yank";          # copy
        "x" = "yank --cut";    # cut/move
        "v" = "paste";         # paste
        "m" = "visual_mode";   # toggle selection mode
        "q" = "escape";
      };
  };
} 
