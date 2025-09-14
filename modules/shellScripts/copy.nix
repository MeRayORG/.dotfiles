{mkBaScript, pkgs, aPath, ...}:
mkBaScript "copy"
''
data="$(cat)$1"
${pkgs.wl-clipboard-rs}/wl-copy "$data"
''