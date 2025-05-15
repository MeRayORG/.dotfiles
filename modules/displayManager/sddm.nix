{config, pkgs, ...}:

{
  services.displayManager = {
    # Enable automatic login for the user.
    autoLogin = {
      enable = false;
      user = "meray";
    };

  };
}
