{
  lib,
  config,
  aPath,
  ...
}:
let
  inherit (lib.attrsets) setAttrByPath attrByPath;
  
  enablePath = aPath ++ ["enable"];
  setOptionToPath = setAttrByPath enablePath;
  enableOpt = lib.mkEnableOption (lib.last aPath);
  getConfigValue = attrByPath enablePath false config;
in
setToEnable: {options = setOptionToPath enableOpt;} // lib.optionalAttrs getConfigValue setToEnable