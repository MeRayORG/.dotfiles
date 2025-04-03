{
  aPath,
  lib,
  ...
}:
{
  hmUser ? false,
  homeDir ? null,
  extraConfig ? {},
  description ? "",
  

}:

let
  userName = lib.last aPath;
  finalHomeDir = if homeDir == null then "/home/${userName}" else homeDir;
in {
  users.users.${userName} = {
    inherit description;
    isNormalUser = true;
    home = finalHomeDir;
    hmUser = hmUser;
  } // extraConfig;
}
