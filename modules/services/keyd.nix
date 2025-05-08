{ 
  lib,
  pkgs,
  config,
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


  config = {
    services.keyd.enable = true;

    environment.systemPackages = [ pkgs.keyd ];

    # This creates the configuration text to be used in /etc/keyd/default.conf
    environment.etc."keyd/default.conf".text = let
      generateOverloads = overloads: lib.concatStringsSep "\n" 
        (map (
          overload:
            let
              getElseKey = holdTap: if overload?"${holdTap}" then overload."${holdTap}" else overload.key;
            in
            "${overload.key} = overload(${getElseKey "hold"}, ${getElseKey "tap"})"
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
  

  options.services.keyd =
  let
    inherit (lib) mkOption;
    inherit (lib.types) listOf attrsOf str; 
  in
  {
    overloads = mkOption {
      type = listOf (attrsOf (str));
      description = "List of home row mod definitions with keys and modifiers.";
      default = [];
    };
    
    remaps = mkOption {
      type = listOf (attrsOf (str));
      description = "List of home row mod definitions with keys and remaps.";
      default = [];
    };
  };
}
