{ mkHome
, pkgs
, ...
} @set:
mkHome set {
  gtk = {
    enable = true;
    theme = {
      name = "Flat-Remix-GTK-Grey-Darkest";
      package = pkgs.flat-remix-gtk;
    };
    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.hyprcursor;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };
}