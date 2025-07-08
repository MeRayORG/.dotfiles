{ mkBaScript
, config
, pkgs
, aPath
, ...
}:
mkBaScript "systemrebuild"
''
message=$1
cd ${config.mods.flakeDir}
git add -A
sudo nixos-rebuild switch --flake . --option warn-dirty false &&
git commit --allow-empty -m "{$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]*')} $message"
''