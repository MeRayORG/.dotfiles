# Creates enableoption out of an aPath

{
  lib,
  ...
}: 
  
aPath:

let
  inherit (lib) mkEnableOption;
  inherit (lib.attrsets) setAttrByPath;
in
  {
    setAttrByPath 
      aPath.setVal
        "enable"
        (mkEnableOption {
          # name = "enable";
          description = "Whether to enable ${aPath.last}"
        })
    ;
  }