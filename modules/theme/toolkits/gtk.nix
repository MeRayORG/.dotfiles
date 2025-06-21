{ mkHome
, pkgs
, config
, ...
} @set:
let 
cfg = config.mods.theme;
t = cfg.theme.gtk;
c = cfg.colors;
p = cfg.cursor; 
i = cfg.icon;
f = cfg.fonts.main;
in
mkHome set {
  gtk = {
    enable = true;
    theme = {
      name = t.name;
      package = t.package;
    };

    ## TODO: set colors
     
    cursorTheme = {
      name = p.name;
      package = p.package;
      size = p.size;
    };
    iconTheme = {
      name = i.name;
      package = i.package;
    };
    font = {
      name = f.main;
      size = f.size;
      package = f.package;
    };
  };
}