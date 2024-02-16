{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    boot = {
        loader = {
            systemd-boot = {
                enable = true;
                editor = false;
            };
            efi.canTouchEfiVariables = true;
            timeout = 0;
        };

        initrd.systemd = {
            enable = true;
            emergencyAccess = false;
            network.wait-online.enable = false;
        };

        kernelPackages = pkgs.unstable.linuxKernel.packages.linux_zen;

        tmp.useTmpfs = true;
    };

    systemd.package = pkgs.systemd;
}
