set@{mkBaScript, pkgs, aPath, ...}:
mkBaScript "copy"
''
data="$(cat)" + $1
wl-copy "$data"
''