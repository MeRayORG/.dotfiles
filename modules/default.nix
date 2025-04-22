{
  lib, pkgs, config, defImp, aPath, id, ...
}: 
id {
  imports = [./wget.nix];
  config = {};
  options = {};
}
# defImp {
#   name = "modules";
#   inherit aPath;
# }
