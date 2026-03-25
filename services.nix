{ ... }:

{
  services = {
    # Power profile & battery consumption controllers
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
