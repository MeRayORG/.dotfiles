{ pkgs
, config
, lib
, mkHome
, ...
}:
{
  environment.systemPackages = with pkgs;[ 
    (yazi.overrideAttrs {runtimeDependencies = [
      git
      fzf
      ouch
    ];})
  ];
} // mkHome config {
  programs.yazi = {
    enable = true;
    enableZshIntegration = config.mods.shell.zsh.enable;
    enableNushellIntegration = config.mods.shell.nush.enable;
    shellWrapperName  = "y";

    plugins = (lib.genAttrs
        [
          "git"
          "ouch"
          "mount"
          "mediainfo"
          "smart-filter"
          "yatline"
          "yatline-githead"
        ] (name: pkgs.yaziPlugins.${name})) // { 
          smarter-filter = ./smarter-filter;
        };

    settings = {
      mgr = {
        show_hidden = true;  # always show dotfiles
      };

      plugin.prepend_fetchers = [
        { 
          id   = "git"; 
          name = "*"; 
          run  = "plugin git";
        } {
          id   = "git";
          name = "*/";
          run  = "plugin git";
        }
      ];
    };
    keymap.mgr.prepend_keymap = 
      lib.mapAttrsToList (key: cmd: { on = key; run = cmd;})
      {
        "i" = "arrow prev";
        "k" = "arrow next";
        "j" = "leave";
        "l" = "enter";

        "c" = "yank";          # copy
        "x" = "yank --cut";    # cut/move
        "v" = "paste";         # paste
        "m" = "visual_mode";   # toggle selection mode
        "q" = "escape";
        "t" = "remove";
      


        ###########
        # Plugins #
        ###########

        ## smart-filter ##
        #"f" = "plugin smart-filter";

        ## smarter-filter ##
        "f" = "plugin smarter-filter";

        ### Not working ######
        "e" = "ouch d";
        "z" = "ouch c";
      };
  };
} 
