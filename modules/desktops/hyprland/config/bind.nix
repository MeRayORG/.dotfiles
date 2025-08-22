{config, ...}:
let 
  menu = "wofi --show drun";
  term = config.mods.programs.terminal.which;
  mod = "SUPER";

  moveWindow = "ALT";

  up = "i";
  down = "k";
  right = "l";
  left = "j";
in
[
"${mod}, space, exec, ${menu}"
"${mod}, t, exec, ${term}"
"${mod}, q, killactive,"

"${mod}, left,  focusplus, l"
"${mod}, right, focusplus, r"
"${mod}, up,    focusplus, u"
"${mod}, down,  focusplus, d"

"${mod}, ${left},  focusplus, l" # "${mod}, ${left},  movefocus, l" 
"${mod}, ${right}, focusplus, r" # "${mod}, ${right}, movefocus, r"
"${mod}, ${up},    focusplus, u" # "${mod}, ${up},    movefocus, u"
"${mod}, ${down},  focusplus, d" # "${mod}, ${down},  movefocus, d"

"${mod}_${moveWindow}, LEFT,  movewindow, l"
"${mod}_${moveWindow}, RIGHT, movewindow, r"
"${mod}_${moveWindow}, UP,    movewindow, u"
"${mod}_${moveWindow}, DOWN,  movewindow, d"
         
"${mod}_${moveWindow}, ${left},  movewindow, l"
"${mod}_${moveWindow}, ${right}, movewindow, r"
"${mod}_${moveWindow}, ${up},    movewindow, u"
"${mod}_${moveWindow}, ${down},  movewindow, d"
]
