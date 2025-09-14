{ mkBaScript
, config
, pkgs
, aPath
, ...
}:
mkBaScript "gc"
''
message="$@"
git add -A 
git commit -m message
''