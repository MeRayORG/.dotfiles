{ mkBaScript
, config
, pkgs
, aPath
, ...
}:
mkBaScript "gca"
''
message="$@"
cd $(git rev-parse --show-toplevel)
git add -A .
git commit -m "$message"
''