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
