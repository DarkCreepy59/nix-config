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
    programs = {
        git.enable = true;
        neovim.enable = true;
        neovim.package = unstable.neovim-unwrapped;
        nano.enable = false; # Because we use neovim
        adb.enable = true;
    };

    environment.systemPackages = with pkgs; [
        acpi
        brightnessctl
        btop
        file
        neofetch
        parallel
        unzip
        wget
        zip
    ];
}
