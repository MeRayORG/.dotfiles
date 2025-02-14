{
  lib,
  modules,
  ...
}:

homeOptSet:
let

  inherit (lib.attrsets) filterAttrs;

  # filterAttrs takes (name: val: bool) arguments
  hmUsers = lib.mkMerge (builtins.attrNames (filterAttrs (name: user: user.hmUser == true) modules.users));

  genSet = set: {
    home-manager.users = lib.genAttrs hmUsers (_: homeOptSet);
  };
in
  genSet
