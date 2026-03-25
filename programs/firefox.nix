{ ... }:

{
  programs.firefox = {
    enable = true; # Firefox web browser
    policies = {
      # Autofill settings
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      # Disable background updates
      BackgroundUpdate = false;

      # Block access to various menus
      BlockAboutAddons = true;
      BlockAboutConfig = true;
      BlockAboutProfiles = true;

      # Block foreign cookies!
      Cookies = {
        Locked = true;
        Behaviour = "reject-foreign";
      };

      DisableFirefoxStudies = true; # Unknown entity disabled
      DisableMasterPasswordCreation = true; # Don't use the built in manager
      DisableProfileImport = true; # Only use firefox data
      DisableSetDesktopBackground = true; # Incompatible w/ niri
      DisplayBookmarksToolbar = "newtab"; # Only bookmarks on newtab
      DisplayMenuBar = "never"; # Disable menu bar function
      DontCheckDefaultBrowser = true; # Firefox os only browser

      # Tracking protection
      EnableTrackingProtection = {
        Value = true;
        Cryptomining = true;
        BaselineExceptions = true;
        ConvenienceExceptions = true;
        Locked = true;
      };

      # Confirm encrypted Media
      EncryptedMediaExtensions = {
        Enabled = false;
      };

      # Extentions
      ExtensionSettings = {
        "78272b6fa58f4a1abaac99321d503a20@proton.me" = {
          installation_mode = "normal_installed";
          private_browsing = true;
        };
        "pywalfox@frewacom.org" = {
          installation_mode = "force_installed";
          private_browsing = false;
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "@testpilot-containers" = {
          installation_mode = "force_installed";
          private_browsing = false;
        };
      };

      # Customize home
      FirefoxHome = {
        Search = true;
        Locked = false;
      };

      # Suggestions
      FirefoxSuggest = {
        SponsoredSuggestions = false;
      };

      # AI
      GenerativeAI = {
        Enabled = false;
        locked = true;
      };

      # homepage
      Homepage = {
        Locked = true;
        StartPage = "homepage";
      };

      # Login Manager
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;

      PictureInPicture = {
        Enabled = true; # Enable picture in picture
      };

      # TODO: Fix printing on host machine first
      PrintingEnabled = false; # Disable printing
    };
  };
}
