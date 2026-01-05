{ pkgs, ... }:

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
  services.displayManager.ly.enable = true;
  services.desktopManager.cosmic.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      # Place printer drivers here...
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
      # Add user packages here...
    ];
  };

  # Enable zsh
  programs.zsh.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.pathsToLink = [ "/share/zsh" ];
  environment.systemPackages = with pkgs; [
    # List system packages here...
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # List additional fonts here...
    ];
  };

  system.stateVersion = "25.05";

}

