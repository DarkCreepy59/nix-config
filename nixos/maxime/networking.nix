{
    config,
    inputs,
    lib,
    modulesPath,
    options,
    specialArgs,
    unstable
}: {
    services.resolved = {
        enable = true;
        dnssec = "true";
        domains = [ "~." ];
        fallbackDns = [
            "1.1.1.1#one.one.one.one"
            "1.0.0.1#one.one.one.one"
        ];
        # TODO: Use DNSOverTLS for everything except univ-lille.fr or eduroam
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

        networks = {
            "15-eduroam-lille" = {
                matchConfig.SSID = "eduroam";
                DHCP = "yes";
                domains = [ "~univ-lille.fr" "~gitlab-etu.fil.univ-lille.fr" ];
            };
        };
    };
}
