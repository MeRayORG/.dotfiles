{ getDir
, mkHome
, lib
, pkgs
, ...
} @set:

lib.listToAttrs (
  map
  ({imported, name,...}: {
    inherit name;
    value = imported set;
  })

(getDir set ./. {}))

