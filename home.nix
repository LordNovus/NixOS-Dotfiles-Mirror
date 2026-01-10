{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    kitty = "kitty";
    ranger = "range";
  };

  # Fetch wallpapers from GitLab
  nova-wallpapers = pkgs.fetchFromGitLab {
    owner = "NovaCrypt";
    repo = "nova-wallpapers";
    rev = "dba82ad9565f709e00f540baec1f098f1b8a722e";
    sha256 = "sha256-mKdkgYkhsnEU4kEbwdcWIJ1YW/B3SgevQCCpD9NAg6A=";
  };
in

{
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

    # Plasma Manager Configuration
    plasma = {
      enable = true;

      # Keep this false to allow manual changes while maintaining reproducibility
      overrideConfig = false;

      #
      # Workspace Configuration (Themes & Appearance)
      #
      workspace = {
        # Look and Feel (global theme)
        lookAndFeel = "org.kde.breezedark.desktop";

        # Icon theme
        iconTheme = "YAMIS";

        # Cursor theme
        cursor = {
          theme = "breeze_cursors";
          size = 18;
        };

        # Wallpaper from GitLab repo
        wallpaper = "${nova-wallpapers}/Wallpaper-Static_014.png";
      };

      #
      # Fonts Configuration
      #
      fonts = {
        general = {
          family = "Noto Sans";
          pointSize = 10;
        };

        fixedWidth = {
          family = "DepartureMono Nerd Font";
          pointSize = 11;
        };
      };

      #
      # Virtual Desktops
      #
      kwin = {
        virtualDesktops = {
          number = 9;
          rows = 1;
          names = [
            "WWW"
            "SYS"
            "CHT"
            "MUS"
            ""
            ""
            ""
            ""
            ""
          ];
        };
      };

      #
      # Keyboard Shortcuts (from rc2nix)
      #
      shortcuts = {
        # Desktop Switching
        "kwin"."Switch to Desktop 1" = "Meta+1";
        "kwin"."Switch to Desktop 2" = "Meta+2";
        "kwin"."Switch to Desktop 3" = "Meta+3";
        "kwin"."Switch to Desktop 4" = "Meta+4";
        "kwin"."Switch to Desktop 5" = "Meta+5";
        "kwin"."Switch to Desktop 6" = "Meta+6";
        "kwin"."Switch to Desktop 7" = "Meta+7";
        "kwin"."Switch to Desktop 8" = "Meta+8";
        "kwin"."Switch to Desktop 9" = "Meta+9";

        # Window Management
        "kwin"."Kill Window" = "Meta+Shift+C";
        "kwin"."Window Close" = "Meta+C";
        "kwin"."Walk Through Windows" = [ "Meta+Tab" "Alt+Tab" ];
        "kwin"."Walk Through Windows (Reverse)" = [ "Meta+Shift+Tab" "Alt+Shift+Tab" ];

        # Zoom
        "kwin"."view_actual_size" = "Meta+0";
        "kwin"."view_zoom_in" = [ "Meta++" "Meta+=" ];
        "kwin"."view_zoom_out" = "Meta+-";

        # Session Management
        "ksmserver"."Lock Session" = "Meta+L";
        "ksmserver"."Log Out" = "Meta+Q";

        # Applications
        "services/kitty.desktop"._launch = "Meta+Return";
        "services/org.kde.krunner.desktop"._launch = "Meta+Space";
        "services/org.kde.kscreen.desktop".ShowOSD = "Meta+P";
        "services/org.kde.plasma.emojier.desktop"._launch = "Meta+.";
        "services/org.kde.spectacle.desktop".RecordRegion = "Meta+R";
        "services/org.kde.spectacle.desktop"._launch = "Print";

        # Keyboard Layout
        "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Alt+Space";

        # Power
        "org_kde_powerdevil".powerProfile = "Meta+B";
      };

      #
      # Low-level config for settings not covered by high-level modules
      #
      configFile = {
        # Terminal Application
        "kdeglobals"."General"."TerminalApplication" = "kitty";
        "kdeglobals"."General"."TerminalService" = "kitty.desktop";

        # Font rendering
        "kdeglobals"."General"."XftAntialias" = true;
        "kdeglobals"."General"."XftHintStyle" = "hintmedium";
        "kdeglobals"."General"."XftSubPixel" = "rgb";

        # Animation speed
        "kdeglobals"."KDE"."AnimationDurationFactor" = 0.7071067811865475;
        "kdeglobals"."KDE"."DndBehavior" = "MoveIfSameDevice";
        "kdeglobals"."KDE"."DoubleClickInterval" = 300;

        # File Dialog settings
        "kdeglobals"."KFileDialog Settings"."Allow Expansion" = false;
        "kdeglobals"."KFileDialog Settings"."Automatically select filename extension" = true;
        "kdeglobals"."KFileDialog Settings"."Breadcrumb Navigation" = true;
        "kdeglobals"."KFileDialog Settings"."Show hidden files" = false;
        "kdeglobals"."KFileDialog Settings"."Sort directories first" = true;

        # KWin Effects
        "kwinrc"."Plugins"."blurEnabled" = false;
        "kwinrc"."Plugins"."diminactiveEnabled" = true;
        "kwinrc"."Plugins"."forceblurEnabled" = true;
        "kwinrc"."Plugins"."fullscreenEnabled" = false;
        "kwinrc"."Plugins"."hidecursorEnabled" = true;
        "kwinrc"."Plugins"."krohnkiteEnabled" = false;
        "kwinrc"."Plugins"."magiclampEnabled" = true;
        "kwinrc"."Plugins"."squashEnabled" = false;
        "kwinrc"."Plugins"."translucencyEnabled" = true;
        "kwinrc"."Plugins"."windowapertureEnabled" = false;
        "kwinrc"."Plugins"."wobblywindowsEnabled" = true;

        # Effect settings
        "kwinrc"."Effect-blur"."NoiseStrength" = 11;
        "kwinrc"."Effect-blurplus"."BlurMatching" = false;
        "kwinrc"."Effect-blurplus"."BlurNonMatching" = true;
        "kwinrc"."Effect-blurplus"."BlurStrength" = 9;
        "kwinrc"."Effect-blurplus"."NoiseStrength" = 0;
        "kwinrc"."Effect-blurplus"."RefractionRGBFringing" = 2;
        "kwinrc"."Effect-blurplus"."RefractionStrength" = 4;
        "kwinrc"."Effect-diminactive"."Strength" = 10;
        "kwinrc"."Effect-translucency"."Inactive" = 70;
        "kwinrc"."Effect-translucency"."MoveResize" = 86;

        # Window Behavior
        "kwinrc"."Windows"."AutoRaise" = true;
        "kwinrc"."Windows"."AutoRaiseInterval" = 0;
        "kwinrc"."Windows"."BorderSnapZone" = 20;
        "kwinrc"."Windows"."ClickRaise" = false;
        "kwinrc"."Windows"."FocusPolicy" = "FocusFollowsMouse";
        "kwinrc"."Windows"."RollOverDesktops" = true;

        # Mouse Bindings
        "kwinrc"."MouseBindings"."CommandActiveTitlebar1" = "Nothing";
        "kwinrc"."MouseBindings"."CommandActiveTitlebar2" = "Minimize";
        "kwinrc"."MouseBindings"."CommandAll2" = "Nothing";
        "kwinrc"."MouseBindings"."CommandAllWheel" = "Change Opacity";
        "kwinrc"."MouseBindings"."CommandInactiveTitlebar1" = "Nothing";
        "kwinrc"."MouseBindings"."CommandInactiveTitlebar2" = "Minimize";
        "kwinrc"."MouseBindings"."CommandWindow1" = "Activate and pass click";

        # Tiling
        "kwinrc"."Tiling"."padding" = 4;

        # Compositing
        "kwinrc"."Compositing"."AllowTearing" = false;

        # KRunner
        "krunnerrc"."General"."FreeFloating" = true;
        "krunnerrc"."General"."historyBehavior" = "ImmediateCompletion";

        # KRunner Plugins
        "krunnerrc"."Plugins"."baloosearchEnabled" = true;
        "krunnerrc"."Plugins"."browserhistoryEnabled" = false;
        "krunnerrc"."Plugins"."browsertabsEnabled" = true;
        "krunnerrc"."Plugins"."calculatorEnabled" = true;
        "krunnerrc"."Plugins"."krunner_appstreamEnabled" = false;
        "krunnerrc"."Plugins"."krunner_bookmarksrunnerEnabled" = true;
        "krunnerrc"."Plugins"."krunner_charrunnerEnabled" = false;
        "krunnerrc"."Plugins"."krunner_colorsEnabled" = true;
        "krunnerrc"."Plugins"."krunner_dictionaryEnabled" = false;
        "krunnerrc"."Plugins"."krunner_katesessionsEnabled" = false;
        "krunnerrc"."Plugins"."krunner_killEnabled" = true;
        "krunnerrc"."Plugins"."krunner_konsoleprofilesEnabled" = false;
        "krunnerrc"."Plugins"."krunner_kwinEnabled" = false;
        "krunnerrc"."Plugins"."krunner_plasma-desktopEnabled" = false;
        "krunnerrc"."Plugins"."krunner_powerdevilEnabled" = false;
        "krunnerrc"."Plugins"."krunner_recentdocumentsEnabled" = false;
        "krunnerrc"."Plugins"."krunner_sessionsEnabled" = false;
        "krunnerrc"."Plugins"."krunner_shellEnabled" = false;
        "krunnerrc"."Plugins"."krunner_spellcheckEnabled" = false;
        "krunnerrc"."Plugins"."krunner_systemsettingsEnabled" = false;
        "krunnerrc"."Plugins"."krunner_webshortcutsEnabled" = true;
        "krunnerrc"."Plugins"."locationsEnabled" = false;
        "krunnerrc"."Plugins"."org.kde.activities2Enabled" = false;
        "krunnerrc"."Plugins"."org.kde.datetimeEnabled" = false;
        "krunnerrc"."Plugins"."unitconverterEnabled" = true;
        "krunnerrc"."Plugins"."windowsEnabled" = true;

        # Web Shortcuts
        "kuriikwsfilterrc"."General"."DefaultWebShortcut" = "duckduckgo";
        "kuriikwsfilterrc"."General"."EnableWebShortcuts" = true;
        "kuriikwsfilterrc"."General"."PreferredWebShortcuts" = "archwiki,dockerhub,protondb,wikipedia,gitlab,duckduckgo,youtube,github,nixpkgs,wikit";
        "kuriikwsfilterrc"."General"."UsePreferredWebShortcutsOnly" = true;

        # KWallet (disabled)
        "kwalletrc"."Wallet"."Enabled" = false;
        "kwalletrc"."Wallet"."First Use" = false;

        # Input devices
        "kcminputrc"."Mouse"."cursorSize" = 18;
        "kcminputrc"."Libinput/1267/12864/ELAN0412:01 04F3:3240 Touchpad"."DisableEventsOnExternalMouse" = true;
        "kcminputrc"."Libinput/1267/12864/ELAN0412:01 04F3:3240 Touchpad"."PointerAccelerationProfile" = 1;
        "kcminputrc"."Libinput/1267/12864/ELAN0412:01 04F3:3240 Touchpad"."ScrollFactor" = 2;

        # Notifications
        "plasmanotifyrc"."Notifications"."PopupTimeout" = 3000;

        # Session
        "ksmserverrc"."General"."loginMode" = "emptySession";

        # Keyboard Layout
        "kxkbrc"."Layout"."LayoutList" = "gb";
        "kxkbrc"."Layout"."Use" = true;

        # Locale
        "plasma-localerc"."Formats"."LANG" = "en_US.UTF-8";
        "plasma-localerc"."Translations"."LANGUAGE" = "en_GB";
      };
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

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

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.05";
}
