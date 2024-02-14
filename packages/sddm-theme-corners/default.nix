{
    pkgs,
    lib,
    stdenvNoCC,
    fetchFromGitHub
}: stdenvNoCC.mkDerivation {
    name = "sddm-theme-corners";
    src = fetchFromGitHub {
        owner = "aczw";
        repo = "sddm-theme-corners";
        rev = "6ff0ff455261badcae36cd7d151a34479f157a3c";
        sha256 = "sha256-CPK3kbc8lroPU8MAeNP8JSStzDCKCvAHhj6yQ1fWKkY=";
    };

    assets = ./assets;

    propagatedBuildInputs = with pkgs; [
        libsForQt5.qt5.qtgraphicaleffects
    ];

    dontWrapQtApps = true;

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
        runHook preInstall

        mkdir -p "$out/share/sddm/themes/"
        cp -r corners/ "$out/share/sddm/themes/sddm-theme-corners"

        cp $assets/hero-bg.png "$out/share/sddm/themes/sddm-theme-corners/backgrounds/"
        cp $assets/theme.conf "$out/share/sddm/themes/sddm-theme-corners/theme.conf"

        runHook postInstall
    '';

    postFixup = ''
        mkdir -p $out/nix-support

        echo ${pkgs.libsForQt5.qt5.qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
    '';

    meta = with lib; {
        licence = licences.gpl3;
        homepage = "https://github.com/aczw/sddm-theme-corners/";
        description = "customizable SDDM theme that puts stuff on your screen corners";
    };
}
