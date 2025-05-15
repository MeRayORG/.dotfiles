{lib, config, ...}:

aPath: setToEnable:
  let
    inherit (lib.attrsets) setAttrByPath attrByPath;
    
    enablePath = aPath ++ ["enable"];
    getConfigValue = attrByPath enablePath false config;
  in
  {
    options = setAttrByPath enablePath (lib.mkEnableOption (lib.last aPath));
    config = lib.mkIf getConfigValue setToEnable;
  }