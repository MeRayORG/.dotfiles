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
      capslock = toggle(editMode)
      
      [editMode]
      capslock = toggle(editMode)

      a = oneshot(control)
      s = oneshot(shift)
      d = oneshot(alt)
      f = oneshot(meta)

      h = left
      j = up
      k = down
      l = right
      m = end
      n = home

      c = C-S-c
      v = C-S-v
      w = C-s
      q = esc
      x = C-c

      u = C-z
      r = C-y

      e = none
      t = none
      y = none
      i = none
      o = none
      p = none
      g = none
      h = none
      z = none
      x = none
      b = none
      
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

      space = toggle(select)
      
      [select]
      space = toggle(select)
      capslock = macro(toggle(editMode)+toggle(select))

      h = S-left
      j = S-up
      k = S-down
      l = S-right
      m = S-end
      n = S-home

      '';
    in
      ''
      [global]
      # layer_indicator = 1

      [ids]
      * = *

      [main]
      
      ${generateOverloads config.services.keyd.overloads}

      ${generateRemaps config.services.keyd.remaps}

      ${if config.services.keyd.capsEditMode then capsenable else ""}
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
