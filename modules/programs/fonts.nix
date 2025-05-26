{ pkgs
, lib
, mkHome
, ... 
}@set: {
  nixpkgs.config.allowUnfree = true;

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;

    packages = [
      pkgs.corefonts
      pkgs.fira-code
      pkgs.noto-fonts
      pkgs.noto-fonts-extra
      pkgs.noto-fonts-cjk-sans
      pkgs.noto-fonts-cjk-serif 
      pkgs.ubuntu-sans
    ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);


    fontconfig = {
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = [  "Ubuntu" ];
        sansSerif = [ "Ubuntu" "Vazirmatn" ];
        monospace = [ "Ubuntu Mono" ];
        };
      };
  };

} // mkHome set {
  fonts.fontconfig.enable = true;
  }