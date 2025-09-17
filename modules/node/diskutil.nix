{ mkEnable
, config
, ...
}:
mkEnable config ["mods" "node" "diskutils"] {
  services.udisks2.enable = true;
  programs.gnome-disks.enable = true;
}
