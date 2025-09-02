{ pkgs
, config
, mkHome
, ...
}:{
    environment.systemPackages = with pkgs; [
        direnv
    ];
} // mkHome config {
    programs.direnv = {
      enable = true;
      enableNushellIntegration = config.mods.shell.nush.enable;
      enableZshIntegration = config.mods.shell.zsh.enable;
    };
}

