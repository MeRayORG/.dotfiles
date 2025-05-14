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
      let 
        editmodespecs = ''
        o = noop
        p = noop
        g = noop
        z = noop

        h = left
        j = up
        k = down
        l = right
        m = end
        n = home
        i = insert

        # Copy Paste Cut
        c = C-c
        v = C-v
        x = C-x

        # Undo Redo
        u = C-z
        r = C-y

        # terminal
        t = M-t
        # explorer
        e = M-e
        # browser
        b = M-b
        # kill app
        q = M-q

        space = M-space

        a = overload(control, C-a)
        s = overload(shift, C-s)
        d = overload(alt, C-d)
        f = overload(meta, C-f)
        
        
        y = escape
        
        ; = backspace
        ' = delete

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
        '';
      in 
      # python: print(''. join( map( (lambda c: f"{c} = {c}\n") , list('1234567890')  ) ) )
      ''
      # if capslock is tapped enable edit mode
      # while held enable edit mode and window mode

      capslock = overload(windowMode, toggle(editMode))
      
      [editMode]
      ${editmodespecs}

      [windowMode]
      ${editmodespecs}

      h = M-left
      j = M-up
      k = M-down
      l = M-right

      left = M-left
      down = M-down
      up = M-up
      right = M-right

      

      [main]

      '';
      accents = 
      ''
      [main]
      # Hold ’ to enter the squote layer; tap ’ to send an apostrophe
      ' = overload(squote, apostrophe)


      [squote]
      e = "é"
      E = "É"
      i = "í"
      I = "Í"


      [main]
      '';
    in
      ''
      [global]
      layer_indicator = 1

      [ids]
      * = *

      [main]
      
      ${generateOverloads config.services.keyd.overloads}

      ${generateRemaps config.services.keyd.remaps}

      ${if config.services.keyd.capsEditMode then capsenable else ""}

      ${if config.services.keyd.addAccents then accents else ""}
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
    addAccents = mkEnableOption "display keys with accents";
  };
}
