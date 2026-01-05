#!/usr/bin/env bash

case "$(echo -e "Dotfiles\nPortfolio" | dmenu -i)" in
    Dotfiles) kitty ~/nixos-dotfiles/ ;;
    Portfolio) kitty ~/Projects/portfolio-site/ ;;
esac
