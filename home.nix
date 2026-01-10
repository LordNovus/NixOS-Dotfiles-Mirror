{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    nvim = "nvim";
    kitty = "kitty";
    ranger = "range";
  };

  # Fetch wallpapers from GitLab
  nova-wallpapers = pkgs.fetchFromGitLab {
    owner = "NovaCrypt";
    repo = "nova-wallpapers";
    rev = "dba82ad9565f709e00f540baec1f098f1b8a722e";
    sha256 = "sha256-mKdkgYkhsnEU4kEbwdcWIJ1YW/B3SgevQCCpD9NAg6A=";
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

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.05";
}
