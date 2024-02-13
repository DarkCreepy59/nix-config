{
    pkgs,
    lib,
    stdenvNoCC,
    fetchurl
}: stdenvNoCC.mkDerivation rec {
    pname = "lucide";
    version = "0.314.0";

    src = fetchurl {
        url = "https://unpkg.com/lucide-static@${version}/font/lucide.ttf";
        hash = "sha256-EKX5QWDBYZcHs/EmWEgh9ZDEb3OJ6AM6GveoyWaIOlc=";
    };

    dontUnpack = true;

    installPhase = ''
        runHook preInstall

        install -Dm644 ${src} -t $out/share/fonts/truetype

        runHook postInstall
    '';

    meta = with lib; {
        homepage = "https://lucide.dev";
    };
}
