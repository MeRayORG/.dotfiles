set @ { 
  mkHome,
  pkgs, 
  ... 
}: {
  environment.systemPackages = with pkgs; [
    libsecret
    gitFull
  ];

  programs.git.enable = true;
} // mkHome set {
  programs.git = {
    enable = true;
    userName = "MeRay";
  };
}

