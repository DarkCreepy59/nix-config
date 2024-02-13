{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    services = {
        xserver = {
            enable = true;

            libinput = {
                touchpad = {
                    tapping = true;
                    naturalScrolling = true;
                };
            };

            videoDrivers = [ "nvidia" ];

            displayManager = {
                sddm = {
                    enable = true;
                    autoNumlock = true;
                    theme = "sddm-theme-corners";
                };
            };

            desktopManager.session = [
                {
                    name = "xsession";
                    start = ''
                        ${pkgs.runtimeShell} $HOME/.xsession&
                        waitPID=$!
                    '';
                }
            ];
        };
    };
}
