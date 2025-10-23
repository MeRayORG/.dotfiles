{ pkgs
, config
, mkHome
, lib
, ...
}:{
  # disable gnome keyring to enable keepass as SecretService
  services.gnome.gnome-keyring.enable = lib.mkForce false;
} // mkHome config {
  home.packages = with pkgs; [keepassxc];
  systemd.user.services.keepassxc = {
    Unit = {
      Description = "KeePassXC Tray Autostart with Secret Service";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.keepassxc}/bin/keepassxc --config ${./config.ini}";
      Restart = "on-abort";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}