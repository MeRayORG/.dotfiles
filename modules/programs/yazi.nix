{ pkgs
, config
, lib
, mkHome
, ...
} @set:

{

  config = ({
    
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
        let
          keymapShortcuts = lib.mapAttrsToList (key: cmd: {
            on = key;
            run = cmd;
            desc = "${cmd} (bound to ${key})";
          });
        in
        keymapShortcuts {
          "i" = "arrow prev";
          "k" = "arrow next";
          "j" = "leave";
          "l" = "enter";
          "e" = "packing extract";
          "c" = "packing compress";
        };
    };
    
  });
}
