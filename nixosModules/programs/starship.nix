# expects option config.shell.which conform to homemanager.
{
  config,
  lib,
  myLib,
  pkgs,
  inputs,
  ...
}: let
  inherit (builtins) hasAttr;
  inherit (lib) mkIf;

  shellsAvailable = hasAttr "shells" config;

  myLib.mkHm = homeSettings: {
    home-manager.users."${config.myNixOS.users.hmUser}" = ({ pkgs, ... }: homeSettings);
  };
  
in {
  environment.systemPackages = [ pkgs.starship ];
  fonts.packages = with pkgs; [ (nerdfonts.override { fonts = [ "FiraMono" ]; }) ];

} // myLib.mkHm {

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = "$shlvl$shell$username$hostname$nix_shell$git_branch$git_commit$git_state$git_status$directory$jobs$cmd_duration$character";
      shlvl = {
        disabled = false;
        symbol = "ﰬ";
        style = "bright-red bold";
      };
    };



    
  } // mkIf (shellsAvailable && config.shells.bash.enable)  {
    enableBashIntegration = true;
  } // mkIf (shellsAvailable && config.shells.nush.enable)  {
    enableNushellIntegration = true;
  } // mkIf (shellsAvailable && config.shells.zsh.enable)  {
    enableZshIntegration = true;
  } // mkIf (shellsAvailable && config.shells.fish.enable)  {
    enableFishIntegration = true;
  };

  
}
