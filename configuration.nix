{ config, lib, pkgs, ... }:

let
  slimbook-keyboard = config.boot.kernelPackages.callPackage
    (
      { stdenv, kernel, fetchFromGitHub }:
      stdenv.mkDerivation {
        pname = "slimbook-keyboard";
        version = "0.0";

        src = fetchFromGitHub {
          owner = "Slimbook-Team";
          repo = "slimbook-keyboard-dkms";
          rev = "master";
          sha256 = "0d9yx6ipcm5b0pxir6pvywfzki7pcfs4azyzwzdaq98pm73fps3a"; # Get this next
        };

        sourceRoot = "source/slimbook_keyboard-0.0"; # Important: point to the module subdirectory

        nativeBuildInputs = kernel.moduleBuildDependencies;

        makeFlags = [
          "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
        ];

        buildPhase = ''
          runHook preBuild
          make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) modules
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build M=$(pwd) INSTALL_MOD_PATH=$out modules_install
          runHook postInstall
        '';

        meta = with lib; {
          description = "Keyboard backlight module for Slimbook Essential/Elemental models";
          homepage = "https://github.com/Slimbook-Team/slimbook-keyboard-dkms";
          license = licenses.gpl3Plus;
          platforms = platforms.linux;
        };
      }
    )
    { };
in
{

  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ./services.nix # System services
      ./programs
    ];

  # Enable flakes 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot configuration
  boot = {
    # Define boot-loader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest; # Linux kernel

    # Add support for slimbook keyboard backlight
    extraModulePackages = [ slimbook-keyboard ];
    kernelModules = [ "clevo_platform" ];
  };

  # Configure network settings
  networking = {
    hostName = "slimbook-nixos"; # Hostname definition
    networkmanager.enable = true; # Enable networkmanager
  };

  # Configure bluetooth settings
  # TODO: Fix bluetooth connectivity issues
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Localization settings
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5"; # For Japanese character input
    fcitx5 = {
      waylandFrontend = true; # Wayland compatability
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        kdePackages.fcitx5-qt
      ];
    };
  };

  time.timeZone = "Europe/London"; # Set system timezone


  # Set security settings...
  security = {
    sudo = {
      extraConfig = ''
        Defaults pwfeedback
      ''; # Enable password feedback '*'s. 
    };
    polkit.enable = true; # Allow apps to request root access popups
  };

  # User setup...
  users = {
    defaultUserShell = pkgs.zsh; # Set ddefaultUserShell to z-shell
    users.novus = {
      # Primary user settings
      isNormalUser = true;
      useDefaultShell = true;
      description = "Oliver"; # For various displays (DisplayManager, Lock Screen)
      extraGroups = [
        "wheel" # Allow user to use `sudo` in terminal
        "networkmanager" # Allow user to configure their network
        "adbusers" # Allow user access to android dev services
      ];
      packages = with pkgs; [
        goofcord # Discord client
        keypunch # Typing practice
        tauon # Music player
        picard # Music tag editor
        kdePackages.kdenlive # Video editor
        pixelorama # Pixel art creator
        inkscape # Vector graphics
        gimp3-with-plugins # Image editor
        gemini-cli # AI in terminal
        wakatime-cli # Time tracking software
      ]; # Install userspace packages
    };
  };

  environment = {
    pathsToLink = [ "/share/zsh" ];
    variables = {
      PATH = "$HOME/.local/bin:/home/novus/.opencode/bin:$PATH";
      QS_ICON_THEME = "Vimix";
      GTK_IM_MODULE = "fcitx";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
    };
    systemPackages = with pkgs; [
      # Basic utitlities
      kitty # Terminal emulator
      libreoffice # Office software
      kdePackages.ark # Zip tool
      kdePackages.okular # PDF viewer
      kdePackages.fcitx5-configtool # Config tool for JP input

      # Command-line essentials
      git # Git commands
      fzf # Fuzzy finder
      ffmpeg # Media formatter
      eza # `ls` alternative
      tree # It's `tree`
      jq # General dependency for many things
      tealdeer # TLDR command
      wget # Get from WWW
      zip # zip utility
      unzip # unzip utility
      lzip # lzip command

      # xwayland support
      xwayland-satellite # xwayland for niri

      # Basic theming
      volantes-cursors # cursor theme
      vimix-icon-theme # icon theme
      pywalfox-native # firefox coloration
      sddm-astronaut # login theme
    ];
  };

  programs = {
    niri.enable = true; # Niri scrolling window manager
    obs-studio = {
      # Open Broadcasting Studio
      enable = true;
      enableVirtualCamera = true; # Enable virtual camera for special effects
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs # Wayland compat
        pixel-art # Add pixel-art effects
        obs-markdown # Add markdown sources
        input-overlay # Overlay keystrokes
        obs-freeze-filter # Freeze a source
        obs-vintage-filter # Vintage film looks
        obs-composite-blur # Blur effects
        obs-pipewire-audio-capture # Captures PipeWire
        obs-retro-effects # Retro effect plugin
      ];
    };
    gnome-disks.enable = true; # Disk management utility
    localsend.enable = true; # Send files over local wifi
    zsh.enable = true; # ZSH shell
    yazi.enable = true; # File manager
    neovim = {
      # Text editor
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };
    zoxide = {
      # `cd` alternative
      enable = true;
      flags = [ "--cmd cd" ]; # Alias `cd`
    };
    bat.enable = true; # `cat` alternative
    git.enable = true; # It is git
    git-lfs.enable = true; # Git large file storage
    gnupg.agent.enable = true; # Encryption agent
    nix-ld.enable = true; # Linter
    adb.enable = true; # Android tools
  };

  fonts = {
    # Font configurations
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.departure-mono
      noto-fonts-cjk-sans
      noto-fonts-cjk-sans-static
      noto-fonts-cjk-serif
      noto-fonts-cjk-serif-static
      source-han-sans
      source-han-serif
      source-han-mono
    ];
  };

  system.stateVersion = "25.05"; # Do not alter!
}

