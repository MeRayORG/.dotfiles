{ getDir
, lib
, pkgs
, ...
} @set:
let dir = (getDir set ./. {}); in

{
  
  pkgs = map ({imported,...}: (imported set).pkg) dir;

settings.plugins = 
lib.listToAttrs
  (map
  ({imported, name,...}: {
    inherit name;
    value = (imported set).set;
  }) dir);


}
