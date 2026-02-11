{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    kitty = "kitty";
    niri = "niri";
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

    # Neovim dependencies 
    ripgrep
    nil
    nixpkgs-fmt
    nodejs
    gcc
    cargo
  ];

  # Icon theme comfiguration
  gtk.iconTheme = {
    name = "Vimix";
    package = pkgs.vimix-icon-theme;
  };

  # Cursor theme config
  home.pointerCursor = {
    enable = true;
    name = "volantes-cursors";
    package = pkgs.volantes-cursors;
    size = 24;
  };

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.05";
}
