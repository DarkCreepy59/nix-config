{
    pkgs,
    ...
}: {
    luastatus-config = pkgs.callPackage ./luastatus-config {};

    dwm-flexipatch = pkgs.callPackage ./dwm-flexipatch {};
    dmenu-flexipatch = pkgs.callPackage ./dmenu-flexipatch {};

    lucide = pkgs.callPackage ./lucide {};

    sddm-theme-corners = pkgs.callPackage ./sddm-theme-corners {};
}
