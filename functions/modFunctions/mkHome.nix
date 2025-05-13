{
  lib,
  config,
  ...
}:
homeOptions:
{
home-manager.users =
  lib.genAttrs
    config.homemanager.users
    (user: homeOptions)
    ;
}

