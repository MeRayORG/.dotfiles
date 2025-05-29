{ pkgs
, mkHome
, lib
, config 
, ...  
}@set:
mkHome set {
  home.shell.enableNushellIntegration = true;
  programs.nushell.enable = true; 
  home.packages = [pkgs.nushell pkgs.oh-my-posh];
  programs.oh-my-posh = 
    { 
      enable = true;
      enableNushellIntegration = config.mods.shell.nush.enable;
      settings = lib.importJSON ./style.json;
  };
}
