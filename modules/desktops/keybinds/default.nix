lib:
let
  allowedMods = [ "C" "S" "A" "M" "F"];
  inherit (builtins) elem filter length all split elemAt;
  nub = lib.lists.unique; # Stupid name. follow convention.

  parseKey = keyStr:
    let
      parts         = split "-" keyStr |> filter (e: e!=[]);
      mods          = filter (x: elem x allowedMods) parts;
      keyCandidates = filter (x: !elem x allowedMods) parts;
    in
      assert length keyCandidates == 1
        || throw "Invalid key string '${keyStr}': must have exactly one non-modifier key";
      assert length mods == length (nub mods)
        || throw "Invalid key string '${keyStr}': duplicate modifiers";
      assert all (x: elem x allowedMods) mods
        || throw "Invalid key string '${keyStr}': unknown modifiers found";
      {
        control = elem "C" mods;
        shift   = elem "S" mods;
        alt     = elem "A" mods;
        meta    = elem "M" mods;
        fn      = elem "F" mods;
        key     = elemAt keyCandidates 0;
      };
in 
  lib.mapAttrsToList (
                        key: 
                        value: 
                                parseKey key // { command = value; })
