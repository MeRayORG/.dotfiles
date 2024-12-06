{
  pkgs,
  config,
  lib,
  inputs,
  outputs,
  myLib,
  ...
}: let


  cfg = config.myNixOS;


  desktops =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.desktops.${name}.enable = lib.mkEnableOption "enable my ${name} desktop";
      };

      configExtension = config: (lib.mkIf cfg.desktops.${name}.enable config);
    })
    (myLib.filesIn ./desktops);

  # Taking all users in ./users and adding bundle.enables to them
  myUsers =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.myUsers.${name}.enable = lib.mkEnableOption "enable ${name} user";
      };

      configExtension = config: (lib.mkIf cfg.myUsers.${name}.enable config);
    })
    (myLib.filesIn ./users);

  # Taking all programs in ./programs and adding program.enables to them
  myPrograms =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.myPrograms.${name}.enable = lib.mkEnableOption "enable ${name} program";
      };

      configExtension = config: (lib.mkIf cfg.myPrograms.${name}.enable config);
    })
    (myLib.filesIn ./programs);

  # Taking all shells in ./shell and adding program.enables to them
  shell =
    myLib.extendModules
    (name: {
      extraOptions = {
        myNixOS.shell.${name}.enable = lib.mkEnableOption "enable ${name} shell";
      };

      configExtension = config: (lib.mkIf cfg.shell.${name}.enable config);
    })
    (myLib.filesIn ./shell);

  # myPrograms = takeModulesFromDirAddEnable myPrograms ./Programs;


in {
  imports =
    [
      # inputs.home.nixosModules.home-manager
    ]
    ++ myUsers
    ++ myPrograms
    ++ desktops
    ++ shell;

  options.myNixOS = {
    
  };
  
  config = {
    nix.settings.experimental-features = ["nix-command" "flakes"];
    programs.nix-ld.enable = true;
    nixpkgs.config.allowUnfree = true;
  };
}
