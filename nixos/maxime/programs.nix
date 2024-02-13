{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    programs = {
        git.enable = true;
        neovim.enable = true;
        neovim.package = pkgs.unstable.neovim-unwrapped;
        nano.enable = false; # Because we use neovim
        adb.enable = true;

        # Also blocks mihoyo telemetry
        anime-game-launcher.enable = true;
    };

    environment.systemPackages = with pkgs; [
        acpi
        brightnessctl
        btop
        file
        neofetch
        parallel
        unzip
        wget
        zip
    ];
}
