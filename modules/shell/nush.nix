{
  pkgs,
  ...
}: {
  environment.systemPackages = [ pkgs.nushell pkgs.carapace];
  users.defaultUserShell = pkgs.nushell;
}
