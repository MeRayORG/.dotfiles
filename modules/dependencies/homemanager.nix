{
  lib,
  ...
}:
{
  options.homemanager.users = lib.mkOption {
    default = lib.warn "No HomeManager Users set." [];
    description = "List of users that the hm config should be applied to.";
    type = lib.types.listOf lib.types.str;
    readOnly = true;
  };
}