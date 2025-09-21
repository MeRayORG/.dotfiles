{ mkBaScript
, config
, pkgs
, aPath
, ...
}:
mkBaScript "md"
''
mkdir -p $@
''