{
    config,
    inputs,
    lib,
    modulesPath,
    options,
    pkgs,
    specialArgs,
    unstable
}: {
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        liberation_ttf
        fira-code
        (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];
}
