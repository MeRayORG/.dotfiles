{ pkgs
, mkHome
, mkEnable
, ...
}@set: 
mkEnable set ["mods" "shell" "zsh"] ({
  environment.systemPackages = [ 
    pkgs.zsh
    pkgs.carapace
    pkgs.fastfetch
  ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
} // mkHome set { 
  home.shell.enableZshIntegration = true;
  programs.carapace.enableZshIntegration = true;
  programs.zsh.enable = true;
  # programs.zsh.configFile.source = ./env.nu;
})
