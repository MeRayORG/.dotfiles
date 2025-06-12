{ pkgs
, mkHome
, lib
, config 
, ...  
}@set:
mkHome set {
  home.packages = [pkgs.oh-my-posh];
  programs.oh-my-posh = 
    { 
      enable = true;
      enableNushellIntegration = config.mods.shell.nush.enable;
      settings = lib.importJSON ./style.json;
  };
}
