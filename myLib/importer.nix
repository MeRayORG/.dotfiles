path: attributePathMaybeDef: currentName: inputset: let
  isNixfile = path: true;
  isFolder = path: true;

  ifIsNix = import path {inherit attributePath inputset;};
  ifIsDir = (import ./importer.nix) ("${path}/${name}") attributePathMaybeDef.currentName name inputset;

  ifNixODir = path: ifIsNix: ifIsDir: 
  if isNixfile path || isFolder path then (
    if isNixfile path then ifIsNix path
    else ifIsDir path)
  else
    [];

  attributePath =
    if (currentName == "default") 
    then attributePathMaybeDef
    else attributePathMaybeDef.currentName;
in 
  flatten (map (ifNixODir) dir)

