{
  aPath,
  lib,
  ...
}: 
  lib.attrsets.setAttrByPath ([options] ++ aPath ++ [enable]) lib.mkEnableOption 