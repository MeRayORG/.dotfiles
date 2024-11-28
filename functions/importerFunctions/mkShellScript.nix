{
  lib, 
  options, 
  config, 
  pkgs, 
  importerAPath,
  ...
}@importerSet:

script:

let
  inherit (lib.attrsets) optionalAttrs;
  scriptName = importerAPath.last;
  shebang = "#!/bin/sh\n";
in
  optionalAttrs 
    aPath.enable 
    {
      environment.systemPackages = [
        (writeShellScriptBin
          scriptName 
          (shebang + script)
        )
      ];
    }