{
  aPath,
  pkgs,
  lib,
  ...
}:

scriptName: script:

let
  # scriptName = lib.last aPath;
  shebang = "#!/bin/sh\n";
in
  {
    environment.systemPackages = [

      (pkgs.writeShellScriptBin
        scriptName 
        (shebang + script)
      )
    ];
  }