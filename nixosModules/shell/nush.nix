{
  pkgs,
  ...
}: {
  environment.systemPackages = [ pkgs.nushell ];
  users.defaultUserShell = pkgs.nushell;
}
