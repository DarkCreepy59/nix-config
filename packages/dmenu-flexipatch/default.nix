{
    pkgs,
    lib,
    stdenv
}: stdenv.mkDerivation {
    name = "dmenu-flexipatch";
    binaryName = "dmenu";
    src = pkgs.fetchFromGitHub {
        owner = "bakkeby";
        repo = "dmenu-flexipatch";
        rev = "0d6d5ac5cc81016b0cd3588b94aa76623dec84de";
        sha256 = "sha256-RvP4vm+7ALYJsz95iuR5sLbxYwqO2Lq+YsmVh8w9R2s=";
    };

    assets = ./.;

    buildInputs = with pkgs; [
        xorg.libX11
        xorg.libXft
        xorg.libXinerama
    ];

    prePatch = ''
        sed -i "s@/usr/local@$out@" config.mk

        cp $assets/patches.h patches.h
        cp $assets/config.h config.h
    '';

    buildPhase = "make";
    installPhase = "make install";

    meta = with lib; {
        homepage = "https://github.com/bakkeby/dmenu-flexipatch";
        description = "A dmenu build with preprocessor directives to decide which patches to include during build time";
        licence = licences.mit;
        platforms = platforms.linux;
    };
}
