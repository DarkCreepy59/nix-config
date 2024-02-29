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
 
    nix = {
        settings = {
            experimental-features = "nix-command flakes";
            auto-optimise-store = true;
        };

        # Map each flake input in the registry
        registry = (lib.mapAttrs (_: flake: { inherit flake; })) ((lib.filterAttrs (_: lib.isType "flake")) inputs);
        channel.enable = false;
    };

    # And then set the nix path from the content of the registry
    nix.nixPath = ["/etc/nix/path"];
    environment.etc = lib.mapAttrs'(name: value: {
        name = "nix/path/${name}";
        value.source = value.flake;
    }) config.nix.registry;

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
