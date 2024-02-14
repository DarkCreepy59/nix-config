{
    pkgs,
    ...
}: {
    luastatus-config = pkgs.callPackage ./luastatus-config {};

    dwm-flexipatch = pkgs.callPackage ./dwm-flexipatch {};
    dmenu-flexipatch = pkgs.callPackage ./dmenu-flexipatch {};

    lucide = pkgs.callPackage ./lucide {};
}
