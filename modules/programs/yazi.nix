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
        mgr = {
          keymap = [
            
          ];
        };
      };      
    };
    
  });
}
