{ pkgs
, mkHome
, mkEnable
, ...
}@set: 
mkEnable set ["mods" "shell" "nush"] ({
  environment.systemPackages = [ pkgs.nushell pkgs.carapace];
  users.defaultUserShell = pkgs.nushell;
} // mkHome set { 
  home.shell.enableNushellIntegration = true;
  programs.carapace.enableNushellIntegration = true;
  programs.nushell.enable = true;
  programs.nushell.configFile.source = ./env.nu;
})
