{ 
  pkgs, 
  ... 
}: {
  environment.systemPackages = with pkgs; [
    libsecret
    gitFull
  ];

  programs.git.enable = true;
}

