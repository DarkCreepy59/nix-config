{
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    };

    outputs = {
        self,
        nixpkgs,
        nixpkgs-unstable
    }: {
    };
}
