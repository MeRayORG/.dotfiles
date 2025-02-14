{
  importerAPath,
  pkgs,
  lib,
  ...
}:

script:

let
  scriptName = lib.last importerAPath;
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