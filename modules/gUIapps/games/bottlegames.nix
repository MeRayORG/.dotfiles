{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    #krb5 # some games need kerberos


    mesa
    mesa-demos
  ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  i18n.supportedLocales = [
    #add for jp games support
    "ja_JP.UTF-8/UTF-8"
  ];

}

