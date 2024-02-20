{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    # TODO: Rename this file
    nixpkgs = {
        config.allowUnfree = true;
        overlays = [
            outputs.overlays.additions
            outputs.overlays.modifications
            outputs.overlays.unstable-packages
        ];
    };

    home = {
        username = "max";
        homeDirectory = "/home/max/";

        sessionVariables = {
            MOZ_USE_XINPUT2 = "1";
        };
    };

    imports = [
        ./terminal.nix
        ./dwm-session.nix
    ];

    home.packages = with pkgs; [
        unstable.osu-lazer-bin
        tetrio-desktop

        nyancat
        zathura
        discord-openasar
        pavucontrol
        unstable.gnome.nautilus

        imhex
        avalonia-ilspy
        renderdoc
        unstable.wineWowPackages.staging

        unstable.ardour
        unstable.yabridge
        drawpile
        blender
        obs-studio
    ];

    programs.btop = {
        enable = true;
        settings = {
            theme_background = false;
        };
    };

    programs.home-manager.enable = true;

    systemd.user.startServices = "sd-switch";
    home.stateVersion = "23.11";
}
