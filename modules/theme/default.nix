{ defImp
, lib
, config
, mkHome
, pkgs
, ... 
}:
let 
  inherit (lib) mkOption;
  inherit (lib.types) enum str derivation;
in
  defImp ./. "theme" // { 
    config = mkHome config {
      
    };
}
