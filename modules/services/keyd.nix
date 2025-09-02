{ 
  lib,
  pkgs,
  config,
  ...
}: {
    options.mods.services.keyd =
  let
    inherit (lib) mkOption mkEnableOption;
    inherit (lib.types) bool;
  in
  {
    
    mode = {
      training = mkEnableOption "Disable most normal modifier keys inluding bsp.";
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
      invertNumbers = mkEnableOption "inverting the symbols and numbers + tilde.";
    };
    nav = {
      shiftToggle = mkOption {
          description = "Whether to have s toggle shift in edit mode.";
          default = true;
          type = bool;
      };
    };
  };


  config = {
    services.keyd.enable = true;
    systemd.services.keyd.restartIfChanged = true;

    environment.systemPackages = [ pkgs.keyd ];

    # This creates the configuration text to be used in /etc/keyd/default.conf
    environment = {
      # point XCOMPOSEFILE at the store path
      variables.XCOMPOSEFILE = "${pkgs.keyd}/share/keyd/keyd.compose";

      etc."keyd/default.conf".text = let

        # include text if option == true
        ifs = option: text: if option then text else "";

        cfg = config.mods.services.keyd;
        left  = "j";
        up    = "i";
        down  = "k";
        right = "l";
        home  = "g";
        end   = "h";

        capsenable =
        # python: print(''. join( map( (lambda c: f"{c} = {c}\n") , list('1234567890')  ) ) )
        ''
        # if capslock is tapped enable edit mode
        # while held enable edit mode and window mode

        capslock = overload(editMode, toggle(editMode))
        ${ifs cfg.mode.edit.space "space = overload(editMode, space)"}
        
        [editMode]
          # quit selection when leaving edit mode
          capslock = overload(editMode, toggle(editMode))
          ${ifs cfg.mode.edit.space "space = overload(main, space)"}

          z = noop
          w = noop
          t = noop
          e = noop
          b = noop
          q = noop
          y = noop  

          ${home} = home 
          # overload(S-home, home)
          ${end}  = end 
          # overload(S-end, end)

          ${left}  = left
          ${up}    = up
          ${down}  = down
          ${right} = right

          u = pageup
          o = pagedown

          # edit in new line below / above
          n = macro(end enter)
          shift+n = macro(home enter up)
          # delete line
          p = macro(end S-home backspace backspace)
          # vscode
          shift+p = macro(end S-home backspace S-home backspace backspace)
 
          # Copy Paste Cut
          c = C-c
          v = C-v
          x = C-x

          # undo redo
          z = C-z
          y = C-y

          a = overload(control, C-a)
          s = overload(shift, C-s)
          d = overload(alt, C-d)
          f = overload(meta, C-f)
          m = toggle(visualMode)
        
          
          q = escape
          
          ; = overload(control, backspace)
          ' = delete
          
          # use symbols in editMode
          1 = !
          2 = @
          3 = #
          4 = $
          5 = %
          6 = ^
          7 = &
          8 = *
          9 = (
          0 = )
          ` = ~



          [editMode+alt]

          [editMode+alt+meta]
          ${up}   = M-A-up
          ${down} = M-A-down


          [editMode+shift]
          o = macro(home enter up)

          [visualMode] 
          ${up}    = S-up
          ${down}  = S-down
          ${left}  = S-left
          ${right} = S-right
          ${home}  = S-home
          ${end}   = S-end
          # quit selection when leaving edit mode
          capslock = overload(editMode, clear())

          # copy, cut, paste then exit selection mode
          c = togglem(visualMode, C-c)
          x = togglem(visualMode, C-x)
          v = togglem(visualMode, C-v)
          ; = overload(control, togglem(visualMode, backspace))

        [main]

        '';

        accents = 
        ''
        [main]
        # Hold ' to enter the squote layer; tap ' to send an apostrophe
        ' = overload(quote, apostrophe)

        [quote]
        e = macro(compose e ')
        E = É
        i = í 
        I = Í

        [qoute+alt]
        e = macro(compose e ")

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
        ${ifs cfg.mode.training ''
          leftcontrol = noop
          leftmeta = noop
          leftalt = noop
          rightalt = noop
          rightcontrol = noop
          rightshift = noop
          backspace = noop
          left = noop 
          right = noop
          up = noop 
          down = noop
          ''}
        

        '';
    };
  };
}
