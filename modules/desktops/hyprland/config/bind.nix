{...}:
let 
  menu = "wofi --show drun";
  #term = config.mods.programs.terminal.which;
  mod = "SUPER";

  moveWindow = "ALT";

  up = "i";
  down = "k";
  right = "l";
  left = "j";
in
[
"${mod}, space, exec, ${menu}"
"${mod}, t, exec, ghostty"
"${mod}, q, killactive,"

"${mod}, left,     movefocus, l"  
"${mod}, right,    movefocus, r"  
"${mod}, up,       exec, focusmove u -2"  
"${mod}, down,     exec, focusmove d +2"  

"${mod}, ${left},  movefocus, l"  
"${mod}, ${right}, movefocus, r"  
"${mod}, ${up},    exec, focusmove u -2"
"${mod}, ${down},  exec, focusmove d +2"

"${mod}_${moveWindow}, LEFT,  movewindow, l"
"${mod}_${moveWindow}, RIGHT, movewindow, r"
"${mod}_${moveWindow}, UP,    exec, windowmove u -2"
"${mod}_${moveWindow}, DOWN,  exec, windowmove d +2"
         
"${mod}_${moveWindow}, ${left},  movewindow, l"
"${mod}_${moveWindow}, ${right}, movewindow, r"
"${mod}_${moveWindow}, ${up},    exec, windowmove u -2"
"${mod}_${moveWindow}, ${down},  exec, windowmove d +2"
]
