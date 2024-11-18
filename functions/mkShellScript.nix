{lib, options, config, pkgs, ...}: aPath: script:
let
  inherit (lib.attrsets) optionalAttrs;
  scriptName = lib.lists.last aPath;
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