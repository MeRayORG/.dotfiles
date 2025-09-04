{ mkBaScript
, config
, pkgs
, aPath
, ...
}:
mkBaScript "systemrebuild"
''
# fuck home manager
# get your shit together 

rm -r /home/meray/.config/gtk-3.0.backup/
rm -r /home/meray/.config/gtk-4.0.backup/
mv /home/meray/.config/gtk-3.0/ /home/meray/.config/gtk-3.0.backup/
mv /home/meray/.config/gtk-4.0/ /home/meray/.config/gtk-4.0.backup/



message="$@"
cd ${config.mods.flakeDir}
git add -A
sudo nixos-rebuild switch --flake . --option warn-dirty false &&
git commit --allow-empty -m "{$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]*')} $message"
''