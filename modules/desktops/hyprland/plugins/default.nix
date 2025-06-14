{ getDir
, lib
, pkgs
, ...
} @set:
let 
getSafe = default: set: attr: set.${attr} or default;
getSafeSet = getSafe {};
getSafeStr = getSafe "";

dir = (getDir set ./. {}); 
in

{
  pkgs = map ({imported,...}: (getSafeStr (imported set) "pkg")) dir;

  settings.plugin = lib.listToAttrs (
    map
      ({imported, name,...}: {
        inherit name;
        value = getSafeSet (imported set) "set";
      }) dir
  );


}
