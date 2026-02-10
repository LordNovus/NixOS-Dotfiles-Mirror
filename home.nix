{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    kitty = "kitty";
    ranger = "range";
  };
in

{
  home.username = "novus";
  home.homeDirectory = "/home/novus";

  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "NovaCrypt";
        email = "novacrypt0512@pm.me";
      };
      lfs.enable = true;
    };
    zsh = {
      enable = true;
      shellAliases = {
        ls = "eza";
        find = "fzf --preview 'bat --color=always {}'";
        opencode = "~/.opencode/bin/opencode";
      };
      autocd = true;
      autosuggestion = {
        enable = true;
        strategy = [ "history" ];
      };
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "alanpeabody";
      };
      initContent = ''
        nitch
      '';
    };
    obsidian = {
      enable = true;
      vaults = {
        Gaming = {
          enable = true;
          target = "Documents/.vaults/Gaming";
        };
        Dotfiles = {
          enable = true;
          target = "Documents/.vaults/Dotfiles";
        };
      };
      defaultSettings = {
        app = {
          vimMode = true;
          defaultViewMode = "source";
        };
      };
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    # zshrc requirement
    nitch

    # KDE dependencies
    kdePackages.qtstyleplugin-kvantum

    # Neovim dependencies 
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    cargo
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.05";
}
