{ pkgs
, config
, mkEnable
, mkHome
, ...
}:
mkEnable config ["mods" "shell" "nush"] ({
  environment.systemPackages = [ 
    pkgs.nushell 
    pkgs.carapace
    pkgs.fastfetch
  ];
  users.defaultUserShell = pkgs.nushell;
} // mkHome config { 
  home.shell.enableNushellIntegration = true;
  programs.carapace.enableNushellIntegration = true;
  programs.nushell.enable = true;
  programs.nushell.configFile.source = ./env.nu;
})
