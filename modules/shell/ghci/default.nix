{ pkgs
, config
, mkEnable
, mkHome
, ...
}:
{
  environment.systemPackages = [
  ];
} // mkHome config { 
  home.file.".ghci".source = ./prompt.hs;
}
