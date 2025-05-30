{ pkgs
, lib
, mkHome
, config
, ... 
}@set: 
let 
  inherit (lib) mkOption;
  inherit (lib.types) package str int bool;
  cfg = config.mods.fonts;
  mono = cfg.mono;
  main = cfg.main;
  reading = cfg.reading;
in 
{
  options = {
    mods.fonts ={
      mostFonts = mkOption {
        type = bool;
        default = true;
      };
      mono = {
        package = mkOption { 
          type = package;
          default = pkgs.nerd-fonts.jetbrains-mono;
        };
        # find using fc-list | grep -i jetbrains
        main = mkOption {
          type = str;
          default = "JetBrainsMono Nerd Font";
        };
        ligatures = mkOption {
          type = bool;
          default = true;
        };
        size = mkOption {
          type = int;
          default = 12;
        };
      };
      main = {
        package = mkOption { 
          type = package;
          default = pkgs.ubuntu-classic;
        };
        # find using fc-list | grep -i jetbrains
        main = mkOption {
          type = str;
          default = "Ubuntu";
        };
        ligatures = mkOption {
          type = bool;
          default = true;
        };
        size = mkOption {
          type = int;
          default = 12;
        };
      };
      reading = {
        package = mkOption { 
          type = package;
          default = pkgs.atkinson-hyperlegible-next;
        };
        # find using fc-list | grep -i jetbrains
        main = mkOption {
          type = str;
          default = "Atkinson Hyperlegible Next Medium";
        };
        ligatures = mkOption {
          type = bool;
          default = true;
        };
        size = mkOption {
          type = int;
          default = 12;
        };
      };

    };
  };
  config = {
    nixpkgs.config.allowUnfree = true;

    fonts = {
      fontDir.enable = true;
      enableDefaultPackages = true;

      packages = [
        main.package
        mono.package
        reading.package
      ] ++ (if cfg.mostFonts then [
        pkgs.corefonts
        pkgs.noto-fonts
        pkgs.noto-fonts-extra
        pkgs.noto-fonts-cjk-sans
        pkgs.noto-fonts-cjk-serif 
      ] else []);


      fontconfig = {
        useEmbeddedBitmaps = true;
        defaultFonts = {
          serif     = [ main.main ];
          sansSerif = [ reading.main ];
          monospace = [ mono.main ];
          };
        };
        
    };

  } // mkHome set {
    fonts.fontconfig = {
      enable = true;

      };
    };
}