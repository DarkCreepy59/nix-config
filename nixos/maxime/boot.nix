{
    config,
    inputs,
    lib,
    modulesPath,
    options,
    specialArgs,
    unstable
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

        kernelPackages = unstable.linuxKernel.packages.linux_zen;

        tmp.useTmpfs = true;
    };

    systemd.package = unstable.systemd;
}
