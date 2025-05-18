set @ {
  pkgs,
  lib,
  mkHome,
  ...
}:
{
  # disable gnome keyring to enable keepass as SecretService
  services.gnome.gnome-keyring.enable = lib.mkForce false;
} // mkHome set {
  home.packages = with pkgs; [keepassxc];
  systemd.user.services.keepassxc = {
    Unit = {
      Description = "KeePassXC Tray Autostart with Secret Service";
      After = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.keepassxc}/bin/keepassxc";
      Restart = "on-abort";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

}

# keepassxc .ini
# MinimizeOnOpenUrl=true

# [Browser]
# CustomProxyLocation=
# Enabled=true
# SearchInAllDatabases=true

# [FdoSecrets]
# Enabled=true

# [GUI]
# ApplicationTheme=dark
# MinimizeOnClose=true
# MinimizeOnStartup=true
# MinimizeToTray=true
# ShowExpiredEntriesOnDatabaseUnlockOffsetDays=2
# ShowTrayIcon=trues