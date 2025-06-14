{...}:{
  workspace_wraparound = true;
  enabled = true;

  bezier = [
    "easeOutQuint,0.23,1,0.32,1"
    "easeInOutCubic,0.65,0.05,0.36,1"
    "linear,0,0,1,1"
    "almostLinear,0.5,0.5,0.75,1.0"
    "quick,0.15,0,0.1,1"
    # macOS-style spring (overshoot, damped bounce)
    "macOSSpr,0.175,0.885,0.32,1.275"
    # Quick fallback
    "quick,0.15,0,0.1,1"
  ];

  animation = [
    # Main spring-open pop-in (like opening from dock/bar)
    "windowsIn,1,6,macOSSpr,popin 120%"

    # Closing with spring
    "windowsOut,1,4,macOSSpr,popin 100%"

    # Resize spring: slide with bounce
    "windows,1,4,macOSSpr,slide"
    
    "global,1,10,default"
    "border,1,5.39,easeOutQuint"
    "fadeIn,1,1.73,almostLinear"
    "fadeOut,1,1.46,almostLinear"
    "fade,1,3.03,quick"
    "layers,1,3.81,easeOutQuint"
    "layersIn,1,4,easeOutQuint,fade"
    "layersOut,1,1.5,linear,fade"
    "fadeLayersIn,1,1.79,almostLinear"
    "fadeLayersOut,1,1.39,almostLinear"
    "workspaces,1,1.94,almostLinear,fade"
    "workspacesIn,1,1.21,almostLinear,fade"
    "workspacesOut,1,1.94,almostLinear,fade"
  ];
}