{ config, lib, pkgs, ... }:

let
  qc71_slimbook_laptop = config.boot.kernelPackages.callPackage
    (
      { stdenv, kernel, fetchFromGitHub }:
      stdenv.mkDerivation {
        pname = "qc71_slimbook_laptop";
        version = "unstable-030126";

        src = fetchFromGitHub {
          owner = "Slimbook-Team";
          repo = "qc71_laptop";
          rev = "slimbook";
          sha256 = "08ysbpr9mq6j2zg4qfm0d3dh16zf908mkf40gbwfm2ms9fd6jfpf";
        };

        nativeBuildInputs = kernel.moduleBuildDependencies;

        makeFlags = kernel.makeFlags ++ [
          "KDIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
          "INSTALL_MOD_PATH=${placeholder "out"}"
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
          description = "Linux kernel platform driver for Slimbook laptops based on QC71";
          homepage = "https://github.com/Slimbook-Team/qc71_laptop";
          license = licenses.gpl2Only;
          maintainers = [ ];
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
  boot.extraModulePackages = [ qc71_slimbook_laptop ];
  boot.kernelModules = [ "qc71_laptop" ];

  # udev rules for user access
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="qc71_laptop::kbd_backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/leds/%k/brightness", GROUP="video"
  '';

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
  services.displayManager.ly.enable = true;

  services.xserver.enable = true;
  services.xserver.windowManager.qtile = {
    enable = true;
    package = pkgs.python313Packages.qtile;
    extraPackages = python313Packages: with pkgs.python313Packages; [
      qtile-extras
    ];
  };

  services.desktopManager.cosmic.enable = true;

  programs.hyprland.enable = true;


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

      # Themes
      papirus-icon-theme
      gruvbox-plus-icons

      # Command-line
      tealdeer
      nitch
      bat
      ffmpeg
      git-lfs
      eza
    ];
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
  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
    # Basic utitlities
    libreoffice
    kitty

    # Command-line essentials
    brightnessctl
    tree
    fzf
    git
    jq
    wget
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.hack
      nerd-fonts.departure-mono
    ];
  };

  system.stateVersion = "25.05";

}

