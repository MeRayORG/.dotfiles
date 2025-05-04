{

  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = {nixpkgs, ... }@inputs :
  let
    f = import ./functions nixpkgs.lib;
  in
    {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        raynix = nixpkgs.lib.nixosSystem {
          modules = [
            ./normal.nix
            ./modules
          ];
          specialArgs = inputs // f // {aPath =[];};
        };
      };
    };
  
}
