{ pkgs, inputs, ... }:

{
  home-manager.users.novus = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
      settings = {
        bar = {
          position = "right";
          density = "comfortable";
          widgets = {
            left = [
              {
                id = "Launcher";
              }
              {
                id = "Clock";
              }
            ];
            center = [
              {
                id = "Workspace";
              }
            ];
            right = [
              {
                id = "Tray";
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "ControlCenter";
              }
            ];
          };
        };
        general = {
          dimmerOpacity = 0.15;
          scaleRation = 0.9;
          telemetryEnabled = true;
        };
        wallpaper = {
          enabled = true;
          directory = "/home/novus/Pictures/Wallpapers";
        };
        appLauncher = {
          terminalCommand = "kitty";
        };
        dock = {
          enabled = false;
        };
        colorSchemes = {
          useWallpaperColors = true;
        };
      };
    };
  };
}
