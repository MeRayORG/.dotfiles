{ mkBaScript
, config
, pkgs
, aPath
, ...
}@set:
mkBaScript set "pkg"
''
NIXPKGS_ALLOW_UNFREE=1 nix run --impure nixpkgs#$@
''