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
