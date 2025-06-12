{...}:
let 
  menu = "wofi --show drun";
  mod = "SUPER";
in
[
"${mod}, space, exec, ${menu}"
"${mod}, q, killactive,"
]
