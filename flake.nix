{

  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    upkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:Aylur/ags";

    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };
  };

  outputs = { nixpkgs
            , stylix
            , ... 
            } @inputs:
    {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        #  = f.mkSystem ./hosts/;
        raytop = 
        let
          # pkg = {
          #   pkgs2405 = import inputs.pkgs2405 { inherit system;};
          #   upkgs = import inputs.upkgs { inherit system;};
          # };
          # your existing helper imports

          pkg = let system = "x86_64-linux"; in {
            pkgs = import inputs.nixpkgs { inherit system;};
            upkgs = import inputs.upkgs { inherit system;};
          };

          moduleFunctions = import ./functions ({
            inherit (nixpkgs) lib;
          } // pkg);

        in nixpkgs.lib.nixosSystem {
          modules = [
            stylix.nixosModules.stylix
            ./hosts/raytop
            ./modules
          ];
          specialArgs = inputs // moduleFunctions;
        };
      };

      defaultTemplate = {
        description = "DevShells";
        path = ./flakes/templates/dev;
      };
      templates = {
        haskell = {
          description = "Haskell Dev Environment";
          path = ./flakes/templates/haskell;
        };
      };

    };
  
}
