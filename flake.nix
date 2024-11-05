{

  description = "NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "github:hyprwm/Hyprland";
    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    ags.url = "github:Aylur/ags";
  };

  outputs = {... }@inputs :
  let
    # super simple boilerplate-reducing
    # lib with a bunch of functions
    myLib = import ./myLib/default.nix {inherit inputs;};
  in
    with myLib; {
      nixosConfigurations = {
        # ===================== NixOS Configurations ===================== #

        raynix = mkSysHome "x86_64-linux" ./hosts/raytop/configurations/normal.nix;
        # work = mkSystem ./hosts/work/configuration.nix;
        # vps = mkSystem ./hosts/vps/configuration.nix;
        # liveiso = mkSystem ./hosts/liveiso/configuration.nix;
      };
      homeConfigurations = {
        # ================ Maintained home configurations ================ #

        "yurii@laptop" = mkHome "x86_64-linux" ./hosts/laptop/home.nix;
        "yurii@work" = mkHome "x86_64-linux" ./hosts/work/home.nix;
      };


      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
  
}
