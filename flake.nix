{

  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = {nixpkgs, ... }@inputs :
  let
    f = import ./functions/modFunctions nixpkgs.lib;
  in
    {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        raynix = nixpkgs.lib.nixosSystem {
          modules = [
            ./hosts/raytop
            ./modules
          ];
          specialArgs = inputs // f;
        };
      };
    };
  
}
