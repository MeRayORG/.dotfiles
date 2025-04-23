{
  lib, pkgs, config, defImp, aPath, id, ...
}@set: 
id set {
  imports = [./wget.nix];
  config = {};
  options = {};
}
# defImp {
#   name = "modules";
#   inherit aPath;
# }
