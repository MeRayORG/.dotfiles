{lib, ...}:
{
  hmUser ? false,
  homeDir ? /home/userName,
}:
aPath:
extraSettings:
let
  userName = lib.lists.last aPath;
in
{
  users.users.userName = {
    home = homeDir;

  } // extraSettings
}