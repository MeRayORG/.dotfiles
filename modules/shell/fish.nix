{ 
  pkgs,
  ...
}: {
  environment.systemPackages = [ pkgs.fish ];
  users.defaultUserShell = pkgs.fish;
  programs.fish.enable = true;
  documentation.man.generateCaches = false;
}
