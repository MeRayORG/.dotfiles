{
  lib, 
  options, 
  config, 
  ...
}:

list:

{
  inherit list;
  last = lib.lists.last list;
  setVal = lib.attrsets.setAttrByPath list;
  addOption = # eg. mkHome {...} |> addOption 
# optionPath =
# configPath = 
}