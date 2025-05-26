{ pkgs
, lib
, ... 
}: {
  nixpkgs.config.allowUnfree = true;
  fonts.fontDir.enable = true;

  fonts.packages = [
    pkgs.corefonts
    pkgs.fira-code
    pkgs.noto-fonts
    pkgs.noto-fonts-extra
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif 
  ] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}