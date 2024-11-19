{
  pkgs,
  ...
}: {
  environment.systemPackages = [ pkgs.nushell ];
  users.defaultUserShell = pkgs.nushell;
  #programs.nushell.enable = true;
}
