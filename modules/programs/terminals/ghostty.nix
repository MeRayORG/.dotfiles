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
            "ctrl+backspace=csi:\x17"
        
            # Ctrl+Delete → kill-word (Alt+D)
            "ctrl+delete=csi:\x1bd"
        
            # Ctrl+Left → backward-word (Alt+B)
            "ctrl+left=csi:\x1bb"
        
            # Ctrl+Right → forward-word (Alt+F)
            "ctrl+right=csi:\x1bf"
          ];
      };
    };
  });
}