{
  importerAPath,
  pkgs,
  ...
}:

name:

script:

let
  scriptName = importerAPath.last;
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