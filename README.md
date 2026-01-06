# NixOS Dotfiles - Slimbook Elemental 15 Configuration

## ⚠️ Important Notice

**This branch contains a personal NixOS configuration specifically tailored for the Slimbook Elemental 15 laptop.** This is my daily driver configuration and includes:

- Hardware-specific drivers and optimizations for Slimbook Elemental 15
- Personal preferences, settings, and workflow tools
- Customizations specific to my use case

**This configuration is NOT a general template.** If you're looking for a starting template to build your own NixOS system, please use the [`core-stable`](../../tree/core-stable) branch instead.

## Who This Branch Is For

This branch is intended for:
- **Slimbook Elemental 15 owners** who want a working reference configuration
- Users who want to see real-world NixOS configuration examples
- Those interested in studying specific hardware integrations for Slimbook devices

If you don't have a Slimbook Elemental 15 or want a more generic starting point, head over to the [`core-stable`](../../tree/core-stable) branch.

## What's Included

This configuration includes:
- Slimbook-specific hardware drivers and kernel modules
- Power management optimizations for Slimbook hardware
- Display, touchpad, and keyboard configurations tuned for the Elemental 15
- My personal application suite and development environment
- Custom keybindings and workflow optimizations

## Using This Configuration

### If You Have a Slimbook Elemental 15

You can use this configuration as a reference or starting point, but you'll likely want to customize it significantly:

#### 1. Clone the Repository

```bash
git clone https://gitlab.com/novacrypt/nixos-dotfiles.git
cd nixos-dotfiles
git checkout slimbook-stable
```

#### 2. Review and Adapt

**Critical customizations needed:**

1. **Replace personal information**:
   - Username and user-specific paths
   - Git configuration and SSH keys
   - Personal preferences and application configs

2. **Update hardware configuration**:
   - While this config is designed for Slimbook Elemental 15, your specific hardware configuration may differ
   - Merge or replace `hardware-configuration.nix` with your own (from `/etc/nixos/hardware-configuration.nix`)

3. **Review installed packages**:
   - This config includes my personal toolset and applications
   - Remove what you don't need, add what you do

4. **Adjust system settings**:
   - Timezone, locale, and regional settings
   - Network configuration
   - Any desktop environment customizations

#### 3. Backup Current Configuration

Always backup your existing configuration before making changes:

```bash
sudo cp -r /etc/nixos /etc/nixos.backup
```

#### 4. Install the Configuration

Choose one of the following methods to install your customized configuration:

**Option 1: Copy files** (simpler, but not git-managed)
```bash
sudo cp -r * /etc/nixos/
```

**Option 2: Symlink** (keeps git integration for easier updates)
```bash
sudo rm -rf /etc/nixos
sudo ln -s $(pwd) /etc/nixos
```

#### 5. Test Your Changes

Before making permanent changes, test your configuration:

```bash
sudo nixos-rebuild test
```

This will activate your configuration for the current session without making it the default on boot. If something goes wrong, a reboot will return you to your previous configuration.

#### 6. Apply Permanently

If the test is successful and everything works as expected:

```bash
sudo nixos-rebuild switch
```

This makes your new configuration the default.

#### 7. Reboot if Needed

Some hardware-specific changes may require a reboot:

```bash
sudo reboot
```

## Slimbook Elemental 15 Hardware Features

This configuration addresses:
- AMD Ryzen CPU optimizations
- AMD GPU drivers and power management
- Touchpad and keyboard backlight
- Battery life optimization
- Thermal management
- Display scaling and color profiles

## Prerequisites

- A fresh or existing NixOS installation on Slimbook Elemental 15
- Familiarity with NixOS configuration
- Understanding that you'll need to adapt personal settings

Need help with NixOS installation? See the [official NixOS installation guide](https://nixos.org/manual/nixos/stable/index.html#sec-installation).

## Maintenance and Updates

To update the system:

```bash
sudo nixos-rebuild switch --upgrade
```

To update channels:

```bash
sudo nix-channel --update
```

## Troubleshooting

If you encounter issues:
- Use `nixos-rebuild switch --show-trace` for detailed error output
- Check that Slimbook-specific drivers are loading correctly with `lsmod`
- Review system logs: `journalctl -xb`
- Consult the [NixOS manual](https://nixos.org/manual/nixos/stable/)

## A Note on Privacy

This configuration may contain references to personal repositories, services, or configurations. Please review thoroughly and remove/replace any personal information before using it yourself.

## Contributing

Found issues specific to Slimbook Elemental 15 hardware? Feel free to open an issue or submit a merge request. Please note that changes should be relevant to Slimbook hardware or generally beneficial - personal preference changes will likely not be merged.

## Resources

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Options Search](https://search.nixos.org/options)
- [Slimbook Official Site](https://slimbook.es/)
- [NixOS Hardware Repository](https://github.com/NixOS/nixos-hardware) - Community hardware configurations
- [NixOS Discourse](https://discourse.nixos.org/)

## License

*(Add your license information here)*

---

**Remember**: If this isn't what you're looking for, check out the [`core-stable`](../../tree/core-stable) branch for a general-purpose template!