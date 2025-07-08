{ pkgs
, mkHome
, lib
, config 
, ...  
}:
mkHome config {
  home.packages = [pkgs.oh-my-posh];
  programs.oh-my-posh = 
    { 
      enable = true;
      enableNushellIntegration = config.mods.shell.nush.enable;
      enableZshIntegration = config.mods.shell.zsh.enable;
      settings = lib.importJSON ./style.json;
  };
}
