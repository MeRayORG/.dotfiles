set@{mkBaScript, pkgs, ...}:
mkBaScript set "copy"
''
data="$(cat)" + $1
wl-copy "$data"
''