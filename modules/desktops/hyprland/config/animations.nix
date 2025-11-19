{...}: {
  workspace_wraparound = true;
  enabled = true;

  # Tahoe-style bezier curves (no spring/overshoot)
  bezier = [
    "easeOutQuint,0.23,1,0.32,1"         # standard ease-out
    "easeInOutCubic,0.42,0,0.58,1"       # smooth ease-in-out
    "linear,0,0,1,1"                      # linear
    "almostLinear,0.25,0.25,0.75,0.75"   # subtle opacity fade
    "quick,0.5,0,0.2,1"                   # fast UI response
    "macOSClassic,0.25,0.1,0.25,1"        # pre-Yosemite macOS curve
  ];

  # Keep your animations structure, only adjusted to Tahoe behavior
  animation = [
    # Window open/close — soft pop, no bounce
    "windowsIn,1,4,easeOutQuint,popin 108%"
    "windowsOut,1,3.5,easeOutQuint,popin 95%"

    # Resize/move windows — smooth, no bounce
    "windows,1,4,easeInOutCubic,slide"

    # Global transitions (menus, popups)
    "global,1,8,easeOutQuint"

    # Border animations — subtle
    "border,1,5.3,easeOutQuint"

    # Fades — quick and gentle
    "fadeIn,1,2,almostLinear"
    "fadeOut,1,1.8,almostLinear"
    "fade,1,2.8,quick"

    # Layers — menus, dialogs
    "layers,1,3.5,easeOutQuint"
    "layersIn,1,3.8,easeOutQuint,fade"
    "layersOut,1,2.4,linear,fade"

    # Workspaces — slide with gentle ease, no bounce
    "workspaces,1,2.4,easeInOutCubic,fade"
    "workspacesIn,1,2.2,easeInOutCubic,fade"
    "workspacesOut,1,2.4,easeOutQuint,fade"
  ];
}
