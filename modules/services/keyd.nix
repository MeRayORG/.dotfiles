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
            "${remap.key} = ${remap.target}"
        ) remaps);

      capsenable =
      # python: print(''. join( map( (lambda c: f"{c} = {c}\n") , list('1234567890')  ) ) )
      ''
      capslock = toggle(editMode, capslock)
      
      [editMode]
      
      a = none
      b = none
      c = none
      d = none
      e = none
      f = none
      g = none
      h = none
      i = none
      j = none
      k = none
      l = none
      m = none
      n = none
      o = none
      p = none
      q = none
      r = none
      s = none
      t = none
      u = none
      v = none
      w = none
      x = none
      y = none
      z = none

      1 = !
      2 = @
      3 = #
      4 = €
      5 = %
      6 = ^
      7 = &
      8 = *
      9 = (
      0 = )

      v = oneshot(shift)
      h = left


      '';
    in
      ''
      [ids]
      * = *

      [main]
      ${generateOverloads config.services.keyd.overloads}
      ${generateRemaps config.services.keyd.remaps}

      # Pressing v triggers oneshot(shift)
      v = oneshot(shift)

      # After pressing v + a, this triggers shift+a and attempts to reapply shift
      q = left oneshot(shift)

      # Fallback: normal key to see when shift is NOT applied
      x = x

      #$\{lib.mkIf config.services.keyd.capsEditMode capsenable}


      '';
  };
  

  options.services.keyd =
  let
    inherit (lib) mkOption mkEnableOption;
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

    capsEditMode = mkEnableOption "the use of [caps] as a toggle for edit mode";
  };
}
