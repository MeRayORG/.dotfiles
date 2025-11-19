{...}: {
  workspace_wraparound = true;
  enabled = true;

  bezier = [
    # Use the default Core Animation timing function that Apple used in classic macOS
    "macOSDefault,0.25,0.1,0.25,1"
    "easeInOut,0.42,0,0.58,1"        # for smoother ease-in-out where needed
    "easeOut,0,0,0.58,1"             # classic ease-out
    "linear,0,0,1,1"
  ];

  animation = [
    # Window open / close — using durations close to CA default (.25s)
    "windowsIn,1,2.5,macOSDefault,popin 110%"
    "windowsOut,1,2.2,macOSDefault,popin 90%"

    # Window move / resize — smooth ease
    "windows,1,2.5,easeInOut,slide"

    # Global transitions (menus, sheets)
    "global,1,3,easeInOut"

    # Border animations — subtle
    "border,1,3.5,easeOut"

    # Fades — default fade durations similar to CA transitions
    "fadeIn,1,2.5,macOSDefault"
    "fadeOut,1,2.5,macOSDefault"
    "fade,1,3,easeInOut"

    # Layers (menus / dialogs)
    "layers,1,3,easeOut"
    "layersIn,1,3.2,easeInOut,fade"
    "layersOut,1,2.5,easeOut,fade"

    # Workspaces — slide + fade
    "workspaces,1,3,easeInOut,fade"
    "workspacesIn,1,2.8,easeInOut,fade"
    "workspacesOut,1,3,easeOut,fade"
  ];
}
