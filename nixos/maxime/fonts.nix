{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
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
