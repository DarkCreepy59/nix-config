{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    services.resolved = {
        enable = true;
        dnssec = "true";
        domains = [ "~." ];
        fallbackDns = [
            "1.1.1.1#one.one.one.one"
            "1.0.0.1#one.one.one.one"
        ];
        # Note: DNSOverTLS breaks intranet, including with VPN
        # TODO: Find a way to use DNSOverTLS without breaking anything
        # extraConfig = ''
        #     DNSOverTLS=yes
        # '';
    };

    networking = {
        hostName = "maxime";
        nameservers = [
            "1.1.1.1#one.one.one.one"
            "1.0.0.1#one.one.one.one"
        ];

        useNetworkd = true;
        wireless.iwd.enable = true;
        
        # Disable NetworkManager and wpa_supplicant
        wireless.enable = false;
        networkmanager.enable = false;

        firewall.enable = false;
    };

    systemd.network = {
        wait-online.enable = false;
    };

    # This depends on an external file, so is sort of impure.
    # Even if I add the config here, authentication would still be a problem.
    services.openvpn.servers."ulille".config = ''
        config /root/nixos/openvpn/ulille.conf

        up ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
        up-restart
        down ${pkgs.update-systemd-resolved}/libexec/openvpn/update-systemd-resolved
        down-pre
    '';
}
