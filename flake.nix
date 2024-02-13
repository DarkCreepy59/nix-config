{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/release-23.11";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        aagl-on-nix = {
            url = "github:ezKEa/aagl-gtk-on-nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        nixpkgs-unstable,
        home-manager,
        aagl-on-nix
    } @ inputs: let
        inherit (self) outputs;

        systems = [
            "x86_64-linux"
            "aarch64-linux"
        ];

        forAllSystems = nixpkgs.lib.genAttrs systems;
    in {
        packages = forAllSystems (system: import ./packages nixpkgs.legacyPackages.${system});

        overlays = import ./overlays { inherit inputs; };

        nixosConfigurations = {
            # My laptop
            "maxime" = nixpkgs.lib.nixosSystem rec {
                specialArgs = { inherit inputs outputs; };
                modules = [ ./nixos/maxime/configuration.nix ];
            };
        };
    };
}
