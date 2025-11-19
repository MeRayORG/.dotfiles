{ #config ,
 ...
}:
let
  #cursor = config.mods.theme.cursor;

in
[
  #"hyprctl setcursor ${cursor.name} ${builtins.toString cursor.size}"

]