{

  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    pkgs2411.url = "github:NixOS/nixpkgs/nixos-24.11";
    pkgs2405.url = "github:NixOS/nixpkgs/nixos-24.05";
    upkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";

    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
  };

  
  outputs = inputs@{ flake-parts, nixpkgs, stylix, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } ({ ... }:
       {
        systems = ["x86_64-linux"];

        # perSystem will be invoked once for each system above
        perSystem = { system, pkgs, lib, ... }:
        let
          pkg = {
            pkgs2405 = import inputs.pkgs2405 { inherit system;};
            upkgs = import inputs.upkgs { inherit system;};
          };
          # your existing helper imports
          moduleFunctions = import ./functions { inherit inputs lib pkgs; } // pkg;
        in {
          packages = { };
          devShells = { };
          nixosConfigurations = {
            # name it however you like
            raytop = nixpkgs.lib.nixosSystem {
              inherit system;
              modules = [
                stylix.nixosModules.stylix
                ./hosts/raytop
                ./modules
              ];
              specialArgs = inputs // moduleFunctions // pkg;
            };
          };
        };
      }
    );
  
}
