{
  importerAPath, 
  ...
}@importerSet:
{
  customAPath ? {},
  hmUser ? false,
  homeDir ? /home/userName,
}:
extraSettings:
let
  aPath = importerAPath // customAPath;
  userName = aPath.last;
in
{
  users.users.${userName} = {
    home = homeDir;

  } // extraSettings;
}