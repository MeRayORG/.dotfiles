{ mkBaScript
, config
, pkgs
, aPath
, ...
}:
mkBaScript "gca"
''
cd $(git rev-parse --show-toplevel)
git add -A 
git commit -m "$@"
''