{
  pkgs,
  ...
}:
  {
    environment.systemPackages = [
      (pkgs.writeShellScriptBin
        "testwssb"
        "echo hello"
      )
    ];
  }