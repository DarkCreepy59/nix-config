{
    inputs,
    ...
}: {
    additions = final: prev: import ../packages { pkgs = final; };

    modifications = final: prev: {
        tetrio-plus-desktop = prev.tetrio-desktop.override {
            withTetrioPlus = true;
        };

        mpv = prev.mpv.override {
            scripts = [ final.mpvScripts.mpris ];
        };

        luastatus = prev.luastatus.overrideAttrs (oldAttrs: {
            # I use the dwm extrastatus patch and separate on a semicolon, and I use
            # a custom patch to center the bar to center of the screen.
            # This patch removes the separator with the previous widget when there is a
            # semicolon
            patches = [ ./patches/luastatus_align_center.patch ];

            # Add coreutils, playerctl,... to the path because my config depends on it
            postFixup = ''
                wrapProgram $out/bin/luastatus \
                    --set PATH ${final.lib.makeBinPath [
                        final.coreutils
                        final.gnused
                        final.gnugrep
                        final.playerctl
                    ]}
            '';
        });
    };

    unstable-packages = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
            system = final.system;
            config.allowUnfree = true;
        };
    };
}
