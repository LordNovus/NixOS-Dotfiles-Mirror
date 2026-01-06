{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    kitty = "kitty";
    qtile = "qtile";
    hypr = "hypr";
    ranger = "range";
  };
in

{
  imports = [ inputs.noctalia.homeModules.default ];

  home.username = "novus";
  home.homeDirectory = "/home/novus";

  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "NovaCrypt";
        email = "novacrypt0512@pm.me";
      };
      lfs.enable = true;
    };
    zsh = {
      enable = true;
      shellAliases = {
        ls = "eza";
        find = "fzf --preview 'bat --color=always {}'";
      };
      autocd = true;
      autosuggestion = {
        enable = true;
        strategy = [ "history" ];
      };
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "alanpeabody";
      };
      initContent = ''
        nitch
      '';
    };
    noctalia-shell = {
      enable = true;
      settings = {
        bar = {
          density = "comfortable";
          position = "top";
          showCapsule = true;
          floating = true;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                id = "Workspace";
                labelMode = "none";
              }
            ];
            center = [
              {
                id = "ActiveWindow";
                colorizeIcons = true;
              }
            ];
            right = [
              {
                id = "Tray";
                colorizeIcons = true;
              }
              {
                id = "MediaMini";
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
              }
              {
                id = "Volume";
                displayMode = "alwaysShow";
              }
              {
                id = "Brightness";
              }
              {
                id = "Clock";
              }
            ];
          };
        };
        ui = {
          fontDefault = "DepartureMono Nerd Font";
          fontFixed = "DepartureMono Nerd Font Mono";
          fontDefaultScale = 0.85;
        };
        location = {
          name = "Swindon, UK";
          firstDayOfWeek = 0;
        };
        wallpaper = {
          directory = "~/Pictures/Wallpapers/";
          randomEnabled = false;
        };
        appLauncher.terminalCommand = "kitty -e";
        dock.enabled = false;
        colorSchemes = {
          useWallpaperColors = true;
          matugenSchemeType = "scheme-tonal-spot";
        };
      };
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    # Hyprland config dependencies
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Qtile config dependencies
    yazi
    (pkgs.dmenu.overrideAttrs
      (_: {
        src =
          /home/novus/nixos-dotfiles/config/dmenu;
        patches = [ ];
      }))

    # Neovim dependencies 
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    cargo
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.05";
}
