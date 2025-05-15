set@{mkShellScript, pkgs, ...}:
mkShellScript set "copy"
''
data="$(cat)" + $1
wl-copy "$data"
''