{ pkgs
, mkHome
, mkEnable
, config
, ...
}: 
mkEnable config ["mods" "shell" "zsh"] ({
  environment.systemPackages = [ 
    pkgs.zsh
    pkgs.carapace
    pkgs.fastfetch
  ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
} // mkHome config { 
  home.shell.enableZshIntegration = true;
  programs.carapace.enableZshIntegration = true;
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
  };
  # programs.zsh.configFile.source = ./env.nu;
})
