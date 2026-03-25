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
      ./services.nix
    ];

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

  networking.hostName = "slimbook-nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  programs.nm-applet.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Desktop Environment settings
  programs.niri.enable = true;

  # Set ssecurity settings...
  security = {
    sudo = {
      extraConfig = ''
        Defaults pwfeedback
      '';
    };
    # Enable policy kit for apps requiring root permission.
    polkit.enable = true;
  };


  # Japanese input method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        kdePackages.fcitx5-qt
      ];
    };
  };

  programs.gnome-disks.enable = true;

  # Localshend over wifi
  programs.localsend.enable = true;

  # Enable flakes 
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.novus = {
    isNormalUser = true;
    useDefaultShell = true;
    description = "Oliver";
    extraGroups = [ "wheel" "networkmanager" "adbusers" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # Programs
      firefox
      goofcord
      libreoffice
      keypunch
      anki
      tauon
      cava
      picard

      # VTubing
      gamescope
      protonup-qt
      steam-tui
      kdePackages.kdenlive
      obs-studio
      obs-studio-plugins.obs-retro-effects

      # Graphics
      krita
      pixelorama
      inkscape
      gimp3-with-plugins

      # Command-line
      gemini-cli
      wakatime-cli
      tealdeer
      bat
      yazi
      ffmpeg
      git-lfs
      eza
      tree
      fzf
    ];
  };

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steamcmd"
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
  ];

  # Enable dynamic binaries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [ ];
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  # Replace cd commands
  programs.zoxide = {
    enable = true;
    flags = [ "--cmd cd" ];
  };

  # Enable zsh
  programs.zsh.enable = true;

  # Enable android interactions
  programs.adb.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
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
      kitty
      kdePackages.ark
      kdePackages.okular
      kdePackages.fcitx5-configtool

      # Command-line essentials
      git
      jq
      wget
      zip
      unzip
      lzip
      gnupg
      pinentry-all

      # xwayland support
      xwayland-satellite

      # Basic theming
      volantes-cursors
      vimix-icon-theme
      pywalfox-native
      sddm-astronaut
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.departure-mono
      # ark-pixel-font # Pixel CJK font
      noto-fonts-cjk-sans
      noto-fonts-cjk-sans-static
      noto-fonts-cjk-serif
      noto-fonts-cjk-serif-static
      source-han-sans
      source-han-serif
      source-han-mono
    ];
  };

  system.stateVersion = "25.05";

}

