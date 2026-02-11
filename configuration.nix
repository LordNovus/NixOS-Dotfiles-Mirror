{ config, lib, pkgs, inputs, ... }:

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
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Add slimbook kernel modules
  boot.extraModulePackages = [ slimbook-keyboard ];
  boot.kernelModules = [ "clevo_platform" ];

  networking.hostName = "slimbook-nixos"; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  programs.nm-applet.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Desktop Environment settings
  services.displayManager.ly.enable = true; # Switch to cosmic?
  # services.desktopManager = {
  #   cosmic.enable = true; # Cosmic desktop
  #   plasma6.enable = true; # KDE Plasma desktop
  # };
  programs.niri.enable = true;


  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      hplip
    ];
  };

  # Enable sound.
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };

  # Enable policy kit for apps requiring root permission.
  security.polkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable disk mounting
  services.udisks2 = {
    enable = true;
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
      cava

      # Command-line
      gemini-cli
      wakatime-cli
      tealdeer
      bat
      ffmpeg
      git-lfs
      eza
      tree
      fzf
    ];
  };

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
    sessionVariables = {
      RANGER_LOAD_DEFAULT_RC = "FALSE";
      PATH = "$HOME/.local/bin:/home/novus/.opencode/bin:$PATH";
    };
    # plasma6.excludePackages = with pkgs.kdePackages; [
    #   plasma-workspace-wallpapers
    #   konsole
    #   krdp
    #   # ark
    #   # okular
    #   kate
    #   ktexteditor
    # ];
    systemPackages = with pkgs; [
      # Basic utitlities
      kitty
      kdePackages.ark
      kdePackages.okular
      kdePackages.dolphin
      kdePackages.elisa

      # Command-line essentials
      git
      jq
      wget
      zip
      unzip
      lzip

      # xwayland support
      xwayland-satellite

      # Plasma plugins
      # inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    ];
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.departure-mono
    ];
  };

  system.stateVersion = "25.05";

}

