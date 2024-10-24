{

  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    
    home = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyperland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, ... }@inputs:
      {
      nixosConfigurations = {
        "raynix" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            
          ];
        };
        gaming = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./gaming.nix
          ];
        };

      };
  };
  
}
