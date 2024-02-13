{
    pkgs,
    lib,
    stdenv
}: stdenv.mkDerivation {
    name = "dwm-flexipatch";
    src = pkgs.fetchFromGitHub {
        owner = "bakkeby";
        repo = "dwm-flexipatch";
        rev = "5a0c5e617f4854e5fb64884d15d6f584c8f72b81";
        sha256 = "sha256-dFiGhkTVoktI4XqwhHEHnFVnDGbyhSvJ6QWZWTjROu4=";
    };

    assets = ./.;

    buildInputs = with pkgs; [
        xorg.libX11
        xorg.libXft
        xorg.libXinerama
        xorg.libXrender
    ];

    prePatch = ''
        sed -i "s@/usr/local@$out@" config.mk

        cp $assets/config.h config.h
        cp $assets/patches.h patches.h
        patch dwm.c $assets/align_center.patch
    '';

    buildPhase = "make";
    installPhase = "make install";

    meta = with lib; {
        description = "A dwm build with preprocessor directives to decide which patches to include during build time";
        homepage = "https://github.com/bakkeby/dwm-flexipatch";
        mainProgram = "dwm";
        licence = licences.mit;
        platforms = platforms.linux;
    };
}
