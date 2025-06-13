{ getDir
, mkHome
, lib
, pkgs
, ...
} @set:

map ({imported,...}: imported set) 

(getDir set ./. {})

