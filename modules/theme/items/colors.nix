{ lib
, config
, ... 
}:
let 
  inherit (lib) mkOption;
  inherit (lib.types) str package;
in
{
  
  # options.mods.theme = {
  #   colors = config.stylix.base16Scheme;
  # };
}