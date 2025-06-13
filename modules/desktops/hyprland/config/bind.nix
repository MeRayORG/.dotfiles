{...}:
let 
  menu = "wofi --show drun";
  mod = "SUPER";
in
[
"${mod}, space, exec, ${menu}"
"${mod}, q, killactive,"

"${mod}, left,  movefocus, l"
"${mod}, right, movefocus, r"
"${mod}, up,    movefocus, u"
"${mod}, down,  movefocus, d"


]
