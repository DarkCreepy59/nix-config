{
    pkgs,
    lib,
    stdenvNoCC
}: stdenvNoCC.mkDerivation {
    name = "luastatus-config";

    src = ./.;

    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
        mkdir -p "$out/share/luastatus/"
        cp -r config/ "$out/share/luastatus/config/"
    '';

    meta = with lib; {
        description = "My Luastatus config";
    };
}
