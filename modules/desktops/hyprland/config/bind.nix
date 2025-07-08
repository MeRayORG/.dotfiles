{...}:
let 
  menu = "wofi --show drun";
  mod = "SUPER";

  moveWindow = "ALT";

  up = "i";
  down = "k";
  right = "l";
  left = "j";
in
[
"${mod}, space, exec, ${menu}"
"${mod}, q, killactive,"

"${mod}, left,  movefocus, l"
"${mod}, right, movefocus, r"
"${mod}, up,    movefocus, u"
"${mod}, down,  movefocus, d"

"${mod}, ${left},  movefocus, l"
"${mod}, ${right}, movefocus, r"
"${mod}, ${up},    movefocus, u"
"${mod}, ${down},  movefocus, d"

"${mod}, ${moveWindow}, LEFT,  movewindow, l"
"${mod}, ${moveWindow}, RIGHT, movewindow, r"
"${mod}, ${moveWindow}, UP,    movewindow, u"
"${mod}, ${moveWindow}, DOWN,  movewindow, d"

"${mod}, ${moveWindow}, ${left},  movewindow, l"
"${mod}, ${moveWindow}, ${right}, movewindow, r"
"${mod}, ${moveWindow}, ${up},    movewindow, u"
"${mod}, ${moveWindow}, ${down},  movewindow, d"
]
