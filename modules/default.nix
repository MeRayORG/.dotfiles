{
  lib, pkgs, config, defImp, aPath, ...
}: 

defImp {
  name = "modules";
  inherit aPath;
}
