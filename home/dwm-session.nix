{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    # Things I need for my dwm session
    # (Only including essential tools)
    programs = {
        kitty = {
            enable = true;

            # Assuming it is installed on the system
            font = {
                name = "FiraCode Nerd Font Mono";
                size = 12.0;
            };

            settings = {
                window_padding_width = 4;
                background_opacity = "0.80";
                sync_to_monitor = true;
            };

            # Colorscheme is managed externally
            extraConfig = ''
                map f1 launch --cwd=current --type=os-window
                include ./palette.conf
            '';

            shellIntegration.enableZshIntegration = true;
        };

        feh.enable = true;

        # Maybe move mpv and firefox elsewhere as they are not really essentials
        mpv.enable = true;
        firefox.enable = true;
    };

    services = {
        picom = {
            enable = true;

            settings = {
                blur = {
                    method = "dual_kawase";
                    strength = 2;
                };

                corner-radius = 12;
                detect-rounded-corners = true;
                rounded-corners-exclude = [
                    "class_g = 'dwm'"
                    "class_g = 'Dunst'"
                ];
            };

            opacityRules = [
                "80:class_g = 'dwm'"
                "85:class_g = 'dmenu'"
            ];

            vSync = true;
            backend = "glx"; # May not be supported on every machine
        };

        dunst = {
            enable = true;

            settings = {
                global = {
                    offset = "10x30";
                    transparency = 20;
                    notification_limit = 0;
                    separator_height = 0;
                    frame_width = 0;
                    gap_size = 10;
                    font = "FiraCode 10";
                    max_icon_size = 48;
                    dmenu = "${pkgs.dmenu-flexipatch}/bin/dmenu -p dunst";
                    browser = "${pkgs.xdg-utils}/bin/xdg-open -p dunst";
                    corner_radius = 6;
                };
                urgency_low = {
                    background = "#212220";
                    foreground = "#fafafa";
                };
                urgency_normal = {
                    background = "#212220";
                    foreground = "#fafafa";
                };
                urgency_critical = {
                    background = "#212220";
                    foreground = "#fafafa";
                };
            };
        };

        # Depends on pipewire (and wireplumber), playerctl, scrot, xclip and libnotify
        sxhkd = {
            enable = true;
            keybindings = {
                "XF86AudioMute" = "wpctl set-mute @DEFAULT_SINK@ toggle";
                "XF86AudioRaiseVolume" = "wpctl set-volume @DEFAULT_SINK@ 2%+";
                "XF86AudioLowerVolume" = "wpctl set-volume @DEFAULT_SINK@ 2%-";
                "XF86MonBrightnessUp" = "brightnessctl s 2%+";
                "XF86MonBrightnessDown" = "brightnessctl s 2%-";
                "XF86AudioPlay" = "playerctl play-pause";
                "XF86AudioNext" = "playerctl next";
                "XF86AudioPrev" = "playerctl previous";
                "Print" = "scrot '/tmp/%F_%T_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f' && notify-send -t 2000 'Screenshot taken'";
            };
        };

        mpris-proxy.enable = true;
    };

    home.packages = with pkgs; [
        dwm-flexipatch
        dmenu-flexipatch
        luastatus
        luastatus-config

        libnotify
        playerctl
        scrot
    ];

    systemd.user.services = {
        "fehbg" = {
            Unit = {
                Description = "Run ~/.fehbg to set wallpaper";
                After = [ "graphical-session-pre.target" ];
                PartOf = [ "graphical-session.target" ];
            };
            Install.WantedBy = [ "graphical-session.target" ];
            Service = {
                Type = "oneshot";
                ExecStart = "%h/.fehbg";
            };
        };

        "luastatus" = {
            Unit = {
                Description = "Luastatus daemon";
                After = [ "graphical-session-pre.target" ];
                PartOf = [ "graphical-session.target" ];
            };
            Install.WantedBy = [ "graphical-session.target" ];
            Service = {
                Type = "simple";
                ExecStart = ''
                    ${pkgs.luastatus}/bin/luastatus                                \
                    -b dwm                                                         \
                    -B separator=' | '                                             \
                    ${pkgs.luastatus-config}/share/luastatus/config/playerctl.lua  \
                    ${pkgs.luastatus-config}/share/luastatus/config/nvidia.lua     \
                    ${pkgs.luastatus-config}/share/luastatus/config/connection.lua \
                    ${pkgs.luastatus-config}/share/luastatus/config/backlight.lua  \
                    ${pkgs.luastatus-config}/share/luastatus/config/alsa.lua       \
                    ${pkgs.luastatus-config}/share/luastatus/config/battery.lua    \
                    ${pkgs.luastatus-config}/share/luastatus/config/time-date.lua
                '';
            };
        };

        "playerctld" = {
            Unit = {
                Description = "Keep track of media player activity";
                PartOf = [ "default.target" ];
            };
            Install.WantedBy = [ "default.target" ];
            Service = {
                Type = "oneshot";
                ExecStart = "${pkgs.playerctl}/bin/playerctld daemon";
            };
        };
    };

    xsession = {
        enable = true;
        windowManager.command = "${pkgs.dwm-flexipatch}/bin/dwm";
    };
}
