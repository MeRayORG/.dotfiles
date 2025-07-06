{ mkHome
, pkgs
, config
, ...
} @set:
let cfg = config.mods.theme; in
{
  environment.sessionVariables = {
      XCURSOR_THEME = cfg.cursor.name;
      XCURSOR_SIZE = cfg.cursor.size;
    };
} //
mkHome config {
  home = {
    
    pointerCursor = {
      package = cfg.cursor.package;
      name = cfg.cursor.name;
      size = cfg.cursor.size;
      x11.enable = true;
    };
  };
    
}