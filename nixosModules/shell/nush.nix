{
  pkgs,
  ...
}: {
  environment.systemPackages = [ pkgs.nush ];
  users.defaultUserShell = pkgs.nush;
  programs.nush.enable = true;
}
