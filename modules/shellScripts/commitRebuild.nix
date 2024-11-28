{mkShellScript, ...}:
mkShellScript
'''
  set message = $1
  set nixconf = ~/.nixconf/.
  git add $nixconf
  sudo nixos-rebuild switch --flake $nixconf
  git commit --allow-empty -m ($message + "{generation: " + (readlink /nix/var/nix/profiles/system | grep -o "[0-9]*") + "}") $nixconf
'''