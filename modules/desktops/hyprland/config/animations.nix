{...}:{
  workspace_wraparound = true;
  enabled = true;
  bezier = [
    "macosSpring, 0.34, 1.56, 0.64, 1.0"
    "macosFade, 0.3, 0.0, 0.2, 1.0"
  ];

  animation = [
    "windows, 1, 6, macosSpring, scale"
    "windowsIn, 1, 6, macosFade, fade"
  ];
}