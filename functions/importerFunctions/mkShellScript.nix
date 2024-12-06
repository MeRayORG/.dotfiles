{
  lib,
  importerAPath,
  pkgs,
  ...
}@importerSet:

script:

let
  inherit (lib.attrsets) optionalAttrs;
  scriptName = importerAPath.last;
  shebang = "#!/bin/sh\n";
in
  optionalAttrs 
    importerAPath.enable 
    {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin
          scriptName 
          (shebang + script)
        )
      ];
    }