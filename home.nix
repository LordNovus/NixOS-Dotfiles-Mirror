{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    kitty = "kitty";
    niri = "niri";
  };
in

{
  home.username = "novus";
  home.homeDirectory = "/home/novus";

  # TODO: Set bookmarks
  programs = {
    firefox = {
      enable = true;
      policies = {
        # Autofill settings
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;

        # Disable background updates
        BackgroundUpdate = false;

        # Block access to various menus
        BlockAboutAddons = false;
        BlockAboutConfig = true;

        # Block foreign cookies!
        Cookies = {
          Locked = true;
          Behaviour = "reject-foreign";
        };

        DisableFirefoxStudies = true; # Unknown entity disabled
        DisableMasterPasswordCreation = true; # Don't use the built in manager
        DisableProfileImport = true; # Only use firefox data
        DisableSetDesktopBackground = true; # Incompatible w/ niri
        DisplayBookmarksToolbar = "newtab"; # Only bookmarks on newtab
        DisplayMenuBar = "never"; # Disable menu bar function
        DontCheckDefaultBrowser = true; # Firefox is only browser

        # Tracking protection
        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          BaselineExceptions = true;
          ConvenienceExceptions = true;
          Locked = true;
        };

        # Confirm encrypted Media
        EncryptedMediaExtensions = {
          Enabled = false;
        };

        # Customize home
        FirefoxHome = {
          Search = true;
          Locked = false;
        };

        # Suggestions
        FirefoxSuggest = {
          SponsoredSuggestions = false;
        };

        # AI
        GenerativeAI = {
          Enabled = false;
          locked = true;
        };

        # homepage
        Homepage = {
          Locked = true;
          StartPage = "homepage";
        };

        # Login Manager
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;

        PictureInPicture = {
          Enabled = true; # Enable picture in picture
        };

        # TODO: Fix printing on host machine first
        PrintingEnabled = false; # Disable printing
      };
      profiles = {
        novus = {
          name = "Novus";
          extensions = {
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
            ];
          };
          # bookmarks.settings = [
          #   {
          #     name = "";
          #     url = "";
          #     tags = [ ];
          #     keyword = "";
          #   }
          #   {
          #     name = "folder";
          #     bookmarks = [ ];
          #   }
          # ];
          containersForce = true;
          containers = {
            work = {
              name = "Work";
              color = "green";
              icon = "briefcase";
            };
          };
        };
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;
      autosuggestion = {
        enable = true;
        strategy = [ "completion" ];
      };
      history = {
        expireDuplicatesFirst = true;
        ignoreSpace = true;
      };
      initContent = ''
        nitch
      '';
      oh-my-zsh = {
        enable = true;
        plugins = [
          "eza"
          "fzf"
          "git"
          "git-auto-fetch"
          "gitignore"
          "git-lfs"
          "kitty"
          "sudo"
          "tldr"
          "zoxide"
        ];
        theme = "alanpeabody";
      };
      shellAliases = {
        find = "fzf --preview 'bat --color=always {}'";
        opencode = "~/.opencode/bin/opencode";
      };
      syntaxHighlighting.enable = true;
    };
    yazi = {
      enableZshIntegration = true;
    };
    git = {
      enable = true;
      settings = {
        user = {
          name = "NovaCrypt";
          email = "novacrypt0512@pm.me";
        };
        push.autoRemoteSetup = true;
      };
      lfs.enable = true;
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  # home.file = {
  #   ".config/qtile" = {
  #     source = "${builtins.fetchGit {
  #       url = "https://gitlab.com/NovaCrypt/dotfiles";
  #       rev = "5568a2ca8d2b73f1e0a6007ba2dbd133c10787f7";
  #     }}/.config/qtile";
  #     recursive = true;
  #   };
  # };

  home.packages = with pkgs; [
    # zshrc requirement
    nitch

    # Neovim dependencies 
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    cargo
  ];

  # Icon theme comfiguration
  gtk.iconTheme = {
    name = "Vimix";
    package = pkgs.vimix-icon-theme;
  };

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.05";
}
