{
    config,
    inputs,
    lib,
    modulesPath,
    options,
    specialArgs,
    unstable
}: {
    hardware = {
        opentabletdriver.enable = true;
        bluetooth.enable = true;

        opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };

        nvidia = {
            modesetting.enable = true;

            powerManagement = {
                enable = true;
                finegrained = true;
            };

            prime = {
                intelBusId = "PCI:0:2:0";
                nvidiaBusId = "PCI:1:0:0";
                offload = {
                    enable = true;
                    enableOffloadCmd = true;
                };
            };
        };
    };

    services = {
        thermald.enable = true;
        tlp.enable = true;
    };
}
