{
  pkgs,
  ... 
}: {
  fonts.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-extra
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif 
  ];
}

