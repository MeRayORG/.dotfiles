{ pkgs
, mkHome
, config
, lib
, ...  
}@set:
let mfCfg = config.mods.theme.fonts.mono; in
{ 
  config = lib.mkIf (config.mods.programs.terminal.which == "ghostty") ({
    environment.systemPackages = [ pkgs.ghostty];
  } //
  mkHome config {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = config.mods.shell.zsh.enable;
    };
  });
}