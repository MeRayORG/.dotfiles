set@{
  mkShellScript,
  lib,
  config,
  pkgs,
  ...
  }:
{
  config = mkShellScript set "systemupdate"
    ''
    cd ${config.mods.flakeDir}
    if [ -z "$(git status --untracked-files=no --porcelain)" ]; then 
      echo "Updating..."
      git add -A .
      nix flake update
      git add -A .
      sudo nixos-rebuild switch --flake . --option warn-dirty false &&
      git commit --allow-empty -m "{$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]*')} UPDATED"
    else
      echo "Uncommitted changes — aborting."
    fi
    '';
}