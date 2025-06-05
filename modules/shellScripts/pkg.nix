{ mkBaScript
, config
, pkgs
, aPath
, ...
}@set:
mkBaScript set "pkg"
''
if [ "$#" -eq 0 ]; then
  echo "Usage: pkg <command> [args...]"
  exit 1
fi

cmd="$1"
shift

NIXPKGS_ALLOW_UNFREE=1 nix run --impure "nixpkgs#$cmd" -- "$@"
''