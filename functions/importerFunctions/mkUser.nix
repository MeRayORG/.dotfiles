{
  importerAPath,
  ...
}:
{
  hmUser ? false,
  homeDir ? null,
}:

let
  userName = importerAPath.last;
  finalHomeDir = if homeDir == null then "/home/${userName}" else homeDir;
in {
  users.users.${userName} = {
    home = finalHomeDir;
    hmUser = hmUser;
  };
}
