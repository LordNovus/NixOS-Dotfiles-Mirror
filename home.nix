{ config, pkgs, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    # Place custom configs for installed packages here...
  };
in

{
  home.username = "novus";
  home.homeDirectory = "/home/novus";

  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        # Add custom aliases here...
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
        export PATH="$HOME/.local/bin:$PATH"
      '';
    };
  };

  # Place custom configurations into .config...
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    # Userspace packages to me unstalled by home-manager
  ];

  fonts.fontconfig.enable = true;

  home.stateVersion = "25.05";
}
