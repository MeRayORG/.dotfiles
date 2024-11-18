lib: aPath:
let
  inherit (lib) mkEnableOption;
  inherit (lib.attrsets) setAttrByPath;
in
{
  setAttrByPath 
    aPath 
    (mkEnableOption {
      name = "enable";
      description = "Whether to enable ${lib.lists.last aPath}"
    })
  ;
}