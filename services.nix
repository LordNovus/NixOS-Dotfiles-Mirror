{ pkgs, ... }:

{
  services = {
    # Set display manager settings
    displayManager = {
      enable = true;
      sddm = {
        enable = true;
        theme = "${pkgs.sddm-astonaut}/share/sddm/themes/sddm-astonaut-theme";
        autoNumlock = true;
        wayland = {
          enable = true;
        };
      };
    };

    # Enable sound.
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    services.libinput.enable = true;

    # Power profile & battery consumption controllers
    power-profiles-daemon.enable = true;
    upower.enable = true;

    # Enable printing services
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplip
      ];
    };
  };
}
