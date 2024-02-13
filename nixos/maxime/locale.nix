{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    time.timeZone = "Europe/Paris";

    i18n = {
        supportedLocales = [
            "en_US.UTF-8/UTF-8"
            "fr_FR.UTF-8/UTF-8"
            "ja_JP.UTF-8/UTF-8"
        ];
        defaultLocale = "en_US.UTF-8";
    };

    console.keyMap = "fr";
    services.xserver.xkb.layout = "fr";
}
