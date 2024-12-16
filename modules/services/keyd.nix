{ 
  lib,
  pkgs,
  ...
}: {




  ## Usage:
  # services.keyd = {
  #   overloads = [
  #     { key = "a";  tap = "a";  hold = "leftcontrol"; }
  #     { key = "s";              hold = "leftshift"; }
  #     { key = "space";          hold = "enter"; }

  #     wrong:
  #       [ "d" "leftalt" ]
  #       [ "f" "leftmeta" ]
  #       [ "j" "rightmeta" ]
  #       [ "k" "rightalt" ]
  #       [ "l" "rightshift" ]
  #       [ ";" "rightcontrol" ]
  #   ];
  #   remaps = [
  #     { key = "capslock"; target = "esc"; }
  #   ];
  # };

  

  environment.systemPackages = [ pkgs.keyd ];

  options.services.keyd = {
    overloads = lib.mkOption {
      type = lib.types.listOf lib.types.attrsOf lib.types.str;
      description = "List of home row mod definitions with keys and modifiers.";
      default = [];
    };
    
    remaps = lib.mkOption {
      type = lib.types.listOf lib.types.attrsOf lib.types.str;
      description = "List of home row mod definitions with keys and remaps.";
      default = [];
    };
  };

  

  config = {
    services.keyd.enable = true;

    # This creates the configuration text to be used in /etc/keyd/default.conf
    environment.etc."keyd/default.conf".text = let
      generateOverloads = overloads: lib.concatStringsSep "\n" 
        (map (
          overload:
            "${overload.key} = overload(${overload.hold ? overload.key}, ${overload.tap ? overload.key})"
        ) overloads);
      generateRemaps = remaps: lib.concatStringsSep "\n" 
        (map (
          remap:
            "${remap.key} = ${remap.target})"
        ) remaps);
    in
      ''
      [ids]
      * = *

      [main]
      ${generateOverloads config.services.keyd.overloads}
      ${generateRemaps config.services.keyd.remaps}
      '';
  };
}
