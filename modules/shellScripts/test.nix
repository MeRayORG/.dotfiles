{
  pkgs,
  ...
}:
  {
    environment.systemPackages = [
      pkgs.neovim-gtk
      (pkgs.writeShellScriptBin
        "testwssb"
        "echo hello"
      )
    ];
  }