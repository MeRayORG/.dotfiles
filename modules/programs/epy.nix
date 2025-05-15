{
  pkgs,
  ...
}:
{
  environment.systemPackages = [pkgs.epy];
}