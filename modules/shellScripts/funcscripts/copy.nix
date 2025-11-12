# can be used to copy to clipboard from commandline  
# Usage:
# echo "Hello " | copy "world."
# results in "Hello world." in the clipboard.
{pkgs, ...}:
''
data="$(cat)$1"
${pkgs.wl-clipboard}/bin/wl-copy "$data"
''