set@{mkShellScript, pkgs, ...}:
mkShellScript set "commitRebuild"
''
message=$1
cd ~/nixconf/.
git add -A
sudo nixos-rebuild switch --flake . --option warn-dirty false
git commit --allow-empty -m '{$(readlink /nix/var/nix/profiles/system | grep -o "[0-9]*")}'
''