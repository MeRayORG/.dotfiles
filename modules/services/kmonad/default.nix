{ 
  lib,
  pkgs,
  config,
  mkHome,
  ...
}: {
    options.mods.services.keyd =
  let
    inherit (lib) mkOption mkEnableOption;
    inherit (lib.types) bool int;
  in
  {
    
    mode = {
      training = mkEnableOption "Disable most normal modifier keys inluding bsp.";
      edit = {
        enable = mkEnableOption "an editmode on capslock.";
        space = mkOption {
          description = "Whether to enable the layer while holding space";
          default = true;
          type = bool;
        };
      };
      #window =  mkEnableOption "windowswitching using righthand navkeys on TWM";
      accents = mkEnableOption "display keys with accents";
    };
    mod = {
      homeRow = {
        enable = mkEnableOption "HomeRowMods";
        idle = mkOption {
          type = int;
          default = 150;
        };
        hold = mkOption {
          type = int;
          default = 200;
        };
      };
      spaceNext = mkEnableOption "going left on tapping shift";
      invertNumbers = mkEnableOption "inverting the symbols and numbers + tilde.";
    };
  };


  config = {
    services.keyd.enable = true;
    systemd.services.keyd.restartIfChanged = true;

    environment.systemPackages = [ pkgs.keyd ];
    #    system.activationScripts.text = ''
    #  ln -sf ${pkgs.keyd}/share/keyd/keyd.compose /usr/share/X11/locale/${config.i18n.defaultLocale}/Compose
    #'';

    # This creates the configuration text to be used in /etc/keyd/default.conf
    environment = {
      # point XCOMPOSEFILE at the store path
      variables.XCOMPOSEFILE = "${pkgs.keyd}/share/keyd/keyd.compose";

      etc."keyd/default.conf".text = import ./config.km ({}// config.mods.services.kmonad);
    };
  }// mkHome config {
    #home.file.".XCompose" = config.lib.file.mkOutOfStoreSymlink "${pkgs.keyd}/share/keyd/keyd.compose";
  };
}
