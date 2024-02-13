{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    programs.zsh.enable = true;

    users.users = {
        "max" = {
            isNormalUser = true;
            extraGroups = [
                "adbusers"
                "realtime"
                "wheel"
            ];
            shell = pkgs.zsh;
        };
    };

    security.rtkit.enable = true;
}
