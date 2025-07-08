{ mkBaScript
, config
, pkgs
, aPath
, ...
}:
mkBaScript "getrebuild"
''
cd ${config.mods.flakeDir}
git rebase main
git add -A
sudo nixos-rebuild switch --flake . --option warn-dirty false &&
git commit --allow-empty --amend -m "{$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]*')} "
chmod -w .
''