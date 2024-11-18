{
  aPath,
  lib,
  ...
}: 
  lib.trivial.warn (builtins.concatStringsSep "." aPath) lib.attrsets.setAttrByPath aPath "maybe"