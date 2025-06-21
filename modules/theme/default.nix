{ defImp
, lib
, config
, mkHome
, pkgs
, ... 
} @set:
let 
  inherit (lib) mkOption;
  inherit (lib.types) enum str derivation;
in
  defImp set ./. "theme" // { 
    config = mkHome set {
      
    };
}
