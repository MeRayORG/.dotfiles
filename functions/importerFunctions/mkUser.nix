{
  aPath,
  lib,
  ...
}:
{
  hmUser ? false,
  homeDir ? null,
}:

let
  userName = lib.last aPath;
  finalHomeDir = if homeDir == null then "/home/${userName}" else homeDir;
in {
  users.users.${userName} = {
    home = finalHomeDir;
    hmUser = hmUser;
  };
}
