set@{
  mkShellScript,
  lib,
  config,
  pkgs,
  ...
  }:
{
  config = mkShellScript set "update"
    ''
    cd ${config.mods.flakeDir}
    if git diff --quiet && git diff --cached --quiet; then
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