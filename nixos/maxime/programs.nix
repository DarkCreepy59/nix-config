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

        # Fix some warnings with GNOME apps
        dconf.enable = true;
    };

    environment.systemPackages = with pkgs; [
        acpi
        brightnessctl
        btop
        ffmpeg
        file
        neofetch
        parallel
        unzip
        wget
        zip

        gnome.adwaita-icon-theme # Install icon theme for GNOME apps
    ];
}
