inputs @ {nixpkgs}:
path:
let
  moduleFunctions = import ../modFunctions nixpkgs.lib;
in
  nixpkgs.lib.nixosSystem {
          modules = [
            {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
            path
            ./modules
          ];
          specialArgs = inputs // moduleFunctions;
        }
