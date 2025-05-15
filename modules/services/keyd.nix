{ 
  lib,
  pkgs,
  config,
  ...
}: {
  config = {
    services.keyd.enable = true;

    environment.systemPackages = [ pkgs.keyd ];

    # This creates the configuration text to be used in /etc/keyd/default.conf
    environment.etc."keyd/default.conf".text = let

      # include text if option == true
      ifs = option: text: if option then text else "";

      cfg = config.mods.services.keyd;
      left  = if cfg.navigation.vim then "h" else "j";
      up    = if cfg.navigation.vim then "j" else "i";
      down  = "k";
      right = "l";
      home  = if cfg.navigation.vim then "n" else "g";
      end   = if cfg.navigation.vim then "m" else "h";
      

      editmodespecs = ''
        ${if cfg.navigation.vim then
        ''
        g = noop
        h = noop
        i = noop
        '' else ''
        m = noop
        n = noop
        ''}

        z = noop
        w = noop
        t = noop
        e = noop
        b = noop
        q = noop
        y = noop 

        ${home} = home
        ${end}  = end

        ${left}  = left
        ${up}    = up
        ${down}  = down
        ${right} = right

        # edit in new line below / above
        o = macro(end enter)
        shift+o = macro(home enter up)
        # delete line
        p = macro(end S-home backspace backspace)
        # vscode
        shift+p = macro(end S-home backspace S-home backspace backspace)


        

        # Copy Paste Cut
        c = C-c
        v = C-v
        x = C-x

        # Undo Redo
        u = C-z
        r = C-y


        a = overload(control, C-a)
        s = overload(shift, C-s)
        d = overload(alt, C-d)
        f = overload(meta, C-f)
        
        
        q = escape
        
        ; = backspace
        ' = delete

        '';

      capsenable =
      # python: print(''. join( map( (lambda c: f"{c} = {c}\n") , list('1234567890')  ) ) )
      ''
      # if capslock is tapped enable edit mode
      # while held enable edit mode and window mode

      capslock = overload(windowMode, toggle(editMode))
      ${ifs cfg.mode.edit.space "space = overload(editMode, space)"}
      
      
      [editMode]
      ${editmodespecs}

      [windowMode]
      ${editmodespecs}

      ${left}  = M-left
      ${up}    = M-up
      ${down}  = M-down
      ${right} = M-right

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

      ${ifs cfg.mod.homeRow 
      ''
      a = overload(control, a)
      s = overload(shift, s)
      d = overload(alt, d)
      f = overload(meta, f)

      j = overload(meta, j)
      k = overload(alt, k)
      l = overload(shift, l)
      ; = overload(control, ;)
      ''}
      ${ifs cfg.mod.spaceNext "leftshift = overload(shift, right)"}
      ${ifs cfg.mode.edit.enable capsenable}
      ${ifs cfg.mode.accents accents}
      '';
  };
  

  options.mods.services.keyd =
  let
    inherit (lib) mkOption mkEnableOption;
    inherit (lib.types) bool; 
  in
  {
    mode = {
      edit = {
        enable = mkEnableOption "an editmode on capslock.";
        space = mkOption {
          description = "Whether to enable the layer while holding space";
          default = true;
          type = bool;
        };
      };
      #window =  mkEnableOption "windowswitching using righthand navkeys on TWM";
      accents = mkEnableOption "display keys with accents";
    };
    mod = {
      homeRow = mkEnableOption "HomeRowMods";
      spaceNext = mkEnableOption "going left on tapping shift";
    };
    navigation = {
      vim = mkOption {
          description = "Whether to navigate using vim keys instead of ijkl(RH-wasd).";
          default = true;
          type = bool;
        };
    };
  };
}


      # generateOverloads = overloads: lib.concatStringsSep "\n" 
      #   (map (
      #     overload:
      #       let
      #         getElseKey = holdTap: if overload?"${holdTap}" then overload."${holdTap}" else overload.key;
      #       in
      #       "${overload.key} = overload(${getElseKey "hold"}, ${getElseKey "tap"})"
      #   ) overloads);

      # generateRemaps = remaps: lib.concatStringsSep "\n" 
      #   (map (
      #     remap:
      #       "${remap.key} = ${remap.target}"
      #   ) remaps);

    # overloads = mkOption {
    #   type = listOf (attrsOf (str));
    #   description = "List of home row mod definitions with keys and modifiers.";
    #   default = [];
    # };
    
    # remaps = mkOption {
    #   type = listOf (attrsOf (str));
    #   description = "List of home row mod definitions with keys and remaps.";
    #   default = [];
    # };