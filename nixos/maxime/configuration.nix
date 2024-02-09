{
    config,
    inputs,
    lib,
    modulesPath,
    options,
    specialArgs,
    unstable
}: {
    imports = [
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
