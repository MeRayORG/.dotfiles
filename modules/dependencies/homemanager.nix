{ lib
, home-manager
, config
, mkHome 
, ...
}:
{
  imports = [
    home-manager.nixosModules.home-manager
  ];

  config = 
  {
    home-manager.users =
      lib.genAttrs
        config.mods.homemanager.users
        (user:
          {
            home = {
              username = "${user}";
              homeDirectory = "/home/${user}";
              stateVersion = "24.11";  # Specify the NixOS version
              sessionVariables = {
                CDPATH = ".:/home/${user}/Documents";
              };
            };
            programs.home-manager.enable = true;
          }
        );
  };

  options.mods.homemanager = {
    users = lib.mkOption {
      default = lib.warn "No HomeManager Users set." [];
      description = "List of users that the hm config should be applied to.";
      type = lib.types.listOf lib.types.str;
    };

  };
}