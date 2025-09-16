# can be used to copy to clipboard from commandline  
# Usage:
# echo "Hello " | copy "world."
# results in "Hello world." in the clipboard.
{mkBaScript, pkgs, aPath, ...}:
mkBaScript "copy"
''
data="$(cat)$1"
${pkgs.wl-clipboard}/bin/wl-copy "$data"
''