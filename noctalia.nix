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
          scaleRatio = 0.85;
          animationSpeed = 1.2;
          shadowDirection = "bottom_left";
          telemetryEnabled = true;
        };
        ui = {
          fontDefault = "Hack Nerd Font";
          fontFixed = "DepartureMono Nerd Font";
          boxBorderEnabled = true;
        };
        location = {
          name = "Swindon, UK";
          weatherShowEffects = false;
        };
        wallpaper = {
          enabled = true;
          directory = "/home/novus/Pictures/Wallpapers";
        };
        appLauncher = {
          terminalCommand = "kitty -e";
          iconMode = "native";
          overviewLayer = true;
          enableSettingsSearch = false;
        };
        controlCenter = {
          shortcuts = {
            left = [
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                id = "PowerProfile";
              }
              {
                id = "Notifications";
              }
            ];
            right = [
              {
                id = "WallpaperSelector";
              }
              {
                id = "NightLight";
              }
              {
                id = "KeepAwake";
              }
            ];
          };
          cards = [
            {
              enabled = true;
              id = "profile-card";
            }
            {
              enabled = true;
              id = "shortcuts-card";
            }
            {
              enabled = false;
              id = "audio-card";
            }
            {
              enabled = false;
              id = "brightness-card";
            }
            {
              enabled = true;
              id = "weather-card";
            }
            {
              enabled = true;
              id = "media-sysmon-card";
            }
          ];
        };
        systemMonitor = {
          diskWarningThreshold = 60;
          diskCriticalThreshold = 85;
          diskAvailWarningThreshold = 40;
          diskAvailCriticalThreshold = 15;
          batteryWarningThreshold = 25;
          batteryCriticalThreshold = 10;
        };
        dock = {
          enabled = false;
        };
        notifications = {
          monitors = [ "eDP-1" ];
        };
        colorSchemes = {
          useWallpaperColors = true;
          schedulingMode = "location";
          generationMethod = "faithful";
        };
        templates = {
          activeTemplates = [
            {
              enabled = true;
              id = "niri";
            }
            {
              enabled = true;
              id = "gtk";
            }
            {
              enabled = true;
              id = "kitty";
            }
            {
              enabled = true;
              id = "cava";
            }
            {
              enabled = true;
              id = "qt";
            }
            {
              enabled = true;
              id = "pywalfox";
            }
          ];
        };
      };
    };
  };
}
