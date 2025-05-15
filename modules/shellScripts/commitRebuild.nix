set@{
  mkShellScript,
  lib,
  config,
  pkgs,
  ...
  }:
{
  config = mkShellScript set "commitRebuild"
    ''
    message=$1
    cd ${config.mods.shellScripts.commitRebuild.flakeDir}
    git add -A
    sudo nixos-rebuild switch --flake . --option warn-dirty false &&
    git commit --allow-empty -m "{$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]*')} $message"
    '';

  options.mods.shellScripts.commitRebuild.flakeDir = lib.mkOption {
          description = "Location of the nix flake(user must have R)";
          type = lib.types.str;
        };
}