if [ "$#" -eq 0 ]; then
  echo "Usage: pkg <command> [more_packages...]"
  exit 1
fi

NIXPKGS_ALLOW_UNFREE=1 nix shell --impure $(for arg in "$@"; do echo -n "\"nixpkgs#$arg\" "; done)
