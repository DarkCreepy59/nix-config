{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: {
    # Most basic things I need for my terminal
    programs = {
        zsh = {
            enable = true;

            history = {
                size = 100000;
                path = "${config.xdg.dataHome}/zsh/history";
            };

            shellAliases = {
                "ls" = "eza";
                "l" = "ls";
                "la" = "ls -a";
                "ll" = "ls -la";
                "lt" = "ls --tree";
            };

            defaultKeymap = "emacs";
            # TODO: Fix some bindings not working
            initExtra = ''
                bindkey "^[[H"  beginning-of-line
                bindkey "^[[F"  end-of-line
                bindkey "^[[3~" delete-char
                bindkey "^[[1;5C" forward-word
                bindkey "^[[1;5D" backward-word
            '';
        };

        starship = {
            enable = true;

            settings = {
                character = {
                    success_symbol = "[>](fg:#63a2ef)";
                    error_symbol = "[>](bold red)";
                    vimcmd_symbol = "[<](bold yellow)";
                };
                directory.style = "fg:bold";
                git_status.disabled = true;
                cmd_duration.disabled = true;
                cmake.disabled = true;
                nix_shell.format = "via [$symbol]($style) ";
            };
        };

        eza = {
            enable = true;
            git = true;
        };

        direnv = {
            enable = true;
            enableZshIntegration = true;
            nix-direnv.enable = true;
        };

        git = {
            enable = true;
            userName = "Maxime Nordier";
            userEmail = "maxime.nordier@gmail.com";
            extraConfig = {
                merge.tool = "nvimdiff";
                diff.tool = "nvimdiff";
                init.defaultBranch = "master";
                difftool.prompt = false;
                difftool.trustExitCode = true;
            };
        };

        # Neovim configuration is managed externally
        neovim = {
            enable = true;
            package = pkgs.unstable.neovim-unwrapped;
            defaultEditor = true;

            extraPackages = with pkgs; [
                unstable.clang # clang for treesitter, should also include clangd
                ripgrep        # for treesitter live grep
                pyright        # for python lsp
                xclip          # for clipboard
            ];
        };
    };

    home.packages = with pkgs; [
        xclip # used by scripts
    ];
}
