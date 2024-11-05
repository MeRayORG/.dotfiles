{ 
  lib,
  pkgs,
  ...
}: {

  environment.systemPackages = [ keyd ];

  options = {
    services.keyd.homeRowMod = lib.mkOption {
      type = lib.types.listOf (lib.types.listOf lib.types.str);
      description = "List of key-modifier pairs as strings.";
      default = [];
    };
  };

  config = {
    services.keyd.enable = true;

    # This creates the configuration text to be used in /etc/keyd/default.conf
    environment.etc."keyd/default.conf".text = let
      generateConfig = pairs: lib.concatStringsSep "\n" (map (pair: let
        [key modifier] = pair;
      in
        "${key} = overload(${modifier}, ${key});") pairs);
    in
      ''
      [ids]
      * = *

      [main]
      ${generateConfig config.services.keyd.homeRowMod}
      '';
  };
}
