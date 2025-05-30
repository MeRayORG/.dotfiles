set@{mkBaScript, pkgs, aPath, ...}:
mkBaScript set "copy"
''
data="$(cat)" + $1
wl-copy "$data"
''