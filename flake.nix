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
    } @ inputs: {
        nixosConfigurations = {
            # My laptop
            "maxime" = nixpkgs.lib.nixosSystem rec {
                system = "x86_64-linux";

                specialArgs = {
                    inherit inputs;

                    unstable = import nixpkgs-unstable {
                        inherit system;
                        config.allowUnfree = true;
                    };
                };

                modules = [ ./nixos/maxime/configuration.nix ];
            };
        };
    };
}
