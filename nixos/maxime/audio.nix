{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    services.pipewire = {
        enable = true;

        alsa.enable = true;
        pulse.enable = true;
        jack.enable = true;
    };

    # Disable pulse because we use pipewire
    hardware.pulseaudio.enable = false;
}
