{
  importerAPath,
  ...
}@importerSet:
{
  hmUser ? false,
  homeDir ? null,
}:
extraSettings:
let
  aPath = importerAPath;
  userName = aPath.last;
  finalHomeDir = if homeDir == null then "/home/${userName}" else homeDir;
in {
  users.users.${userName} = {
    home = finalHomeDir;
    hmUser = hmUser;
  } // extraSettings;
}
