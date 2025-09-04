{ pkgs
, mkHome
, config
, lib
, ...  
}:
let mfCfg = config.mods.theme.fonts.mono; in
{ 
  config = lib.mkIf (config.mods.programs.terminal.which == "ghostty") ({
    environment.systemPackages = [ pkgs.ghostty];
  } //
  mkHome config {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = config.mods.shell.zsh.enable;
      settings = {
          keybind = [
            # Ctrl+Backspace → backward-kill-word (Ctrl+W)
            "ctrl+backspace=csi:23"
        
            # Ctrl+Delete → kill-word (Alt+D)
            "ctrl+delete=csi:445"
        
            # Ctrl+Left → backward-word (Alt+B)
            "ctrl+left=csi:443"
        
            # Ctrl+Right → forward-word (Alt+F)
            "ctrl+right=csi:447"
          ];
      };
    };
  });
}