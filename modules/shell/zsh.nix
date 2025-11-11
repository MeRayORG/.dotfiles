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
    autosuggestion.enable = true;
    completionInit = ''
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
    '';
  };

})
