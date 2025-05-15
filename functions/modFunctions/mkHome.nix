{
  lib,
  config,
  ...
}:
homeOptions:
{
home-manager.users =
  lib.genAttrs
    config.mods.homemanager.users
    (user: homeOptions)
    ;
}

