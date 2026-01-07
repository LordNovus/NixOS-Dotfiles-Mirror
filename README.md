# NixOS Dotfiles - Core Configuration Template

This repository contains a comprehensive NixOS configuration template designed to help you build your own customized NixOS system. It provides a well-structured starting point with sensible defaults and clear organization.

> **Note for Slimbook Elemental 15 users:** If you're using a Slimbook Elemental 15, please check out the [`slimbook-stable`](https://gitlab.com/NovaCrypt/nixos-dotfiles/-/tree/slimbook-stable?ref_type=heads) branch instead, which includes hardware-specific drivers and optimizations.

## Overview

This configuration template uses placeholder values that you'll need to customize for your system:
- **Username**: `user` (default placeholder)
- **Hostname**: `core-nixos` (default placeholder)
- **Other system-specific settings**: Review and adjust to match your hardware and preferences

The configuration is modular and well-commented to make customization straightforward.

## Prerequisites

- A fresh NixOS installation (or the ability to perform one)
- Basic familiarity with NixOS configuration concepts
- Git installed on your system

If you need help installing NixOS, refer to the [official NixOS installation guide](https://nixos.org/manual/nixos/stable/index.html#sec-installation).

## Installation & Usage

### 1. Clone the Repository

On your NixOS system, clone this repository to a convenient location:

```bash
git clone https://gitlab.com/novacrypt/nixos-dotfiles.git
cd nixos-dotfiles
```

### 2. Review and Customize

Before applying the configuration, you'll need to customize it for your system:

1. **Hardware configuration**: 
   - This configuration references `/etc/nixos/hardware-configuration.nix` from your userspace directory
   - While the config links to your existing hardware configuration, your specific setup may differ
   - If you've modified the imports at the top of `configuration.nix`, adjust the build commands accordingly

2. **Replace personal information**:
   - Username and user-specific paths (default: `user`)
   - Hostname (default: `core-nixos`)
   - Git configuration and SSH keys
   - Personal preferences and application configs

3. **Add your packages**: 
   - This config is minimal and only includes the COSMIC desktop environment
   - **You MUST add any additional packages you need** in the commented sections within `configuration.nix` and `home.nix`
   - You can use the COSMIC desktop text editor to edit these files, or nano if you prefer

4. **Adjust system settings**:
   - Timezone, locale, and regional settings
   - Network hostname and other network settings
   - Desktop environment/window manager preferences (if you don't want COSMIC)
   - Boot loader configuration

### 3. Backup Current Configuration

**Always** backup your existing configuration before making changes:

```bash
sudo cp -r /etc/nixos /etc/nixos.backup
```

### 4. Build and Apply the Configuration

This is a **flake-based configuration** that runs directly from your home directory (unlike traditional configs that live in `/etc/nixos/`). It references your existing `/etc/nixos/hardware-configuration.nix` file for hardware-specific settings.

Where `#core-nixos` is your hostname...

**Test your configuration first:**
```bash
sudo nixos-rebuild test --impure --flake ~/nixos-dotfiles#core-nixos --experimental-options "nix-command flakes"
```

This activates the configuration for your current session only. If something breaks, a reboot returns you to your previous configuration.

**If the test succeeds, make it permanent:**
```bash
sudo nixos-rebuild switch --impure --flake ~/nixos-dotfiles#core-nixos --experimental-options "nix-command flakes"
```

**Note:** For future updates, you can omit `--experimental-options "nix-command flakes"` as these options are enabled in the configuration itself.

### 5. Reboot if Needed

Some hardware-specific changes may require a reboot:

```bash
sudo reboot
```

## Configuration Structure

```
.
├── flake.nix              # Flake configuration
├── configuration.nix      # Main system configuration
├── home.nix              # Home-manager configuration
└── modules/              # Optional: modular configuration components
```

*(Adjust this structure to match your actual repository layout)*

## Maintenance and Updates

To update your system:

```bash
sudo nixos-rebuild switch --impure --flake ~/nixos-dotfiles#core-nixos
```

To update flake inputs:

```bash
cd ~/nixos-dotfiles
sudo nix flake update
```

## Troubleshooting

If you encounter issues during `nixos-rebuild`:
- Use `nixos-rebuild switch --flake ~/nixos-dotfiles#core-nixos --show-trace` for detailed error output
- Check the error messages carefully - they often point to syntax errors or missing options
- Review system logs: `journalctl -xb`
- Consult the [NixOS manual](https://nixos.org/manual/nixos/stable/) and [NixOS options search](https://search.nixos.org/options)

## Contributing

Contributions, suggestions, and improvements are welcome! Feel free to open issues or submit merge requests.

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Options Search](https://search.nixos.org/options)
- [NixOS Packages Search](https://search.nixos.org/packages)
- [NixOS Wiki](https://nixos.wiki/)
- [NixOS Discourse](https://discourse.nixos.org/)