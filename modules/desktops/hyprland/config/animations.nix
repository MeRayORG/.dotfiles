{...}:{
  workspace_wraparound = true;
    enabled = true;

    bezier = [
      "tahoeSpring, 0.34, 1.56, 0.64, 1.0"
      "tahoeFade, 0.3, 0.0, 0.2, 1.0"
    ];

    animation = [
      "windows, 1, 6, tahoeSpring, popin 90%"
      "fadeIn, 1, 6, tahoeFade"
    ];
}