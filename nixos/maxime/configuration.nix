{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    nixpkgs = {
        config.allowUnfree = true;
        overlays = [
            outputs.overlays.additions
            outputs.overlays.modifications
            outputs.overlays.unstable-packages
        ];
    };

    nix.settings = {
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;
    };

    imports = [
        inputs.aagl-on-nix.nixosModules.default

        ./hardware-configuration.nix

        ./audio.nix
        ./boot.nix
        ./fonts.nix
        ./hardware.nix
        ./locale.nix
        ./networking.nix
        ./programs.nix
        ./users.nix
        ./x.nix
    ];

    system.stateVersion = "23.11";
}
