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
    };

    unstable-packages = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
            system = final.system;
            config.allowUnfree = true;
        };
    };
}
