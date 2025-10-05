# Novus' NixOS Dotfiles

These dotfiles can be pulled into a NixOS instance to fully replicate my 
day-to-day system. Anybody who wishes to do so can do so, the system is fairly
minimal but is opinionated and esigned around my own prefrences/system 
requirements and that will not change.

## Usage & Installation

Installation of these dotfiles requires a NixOS instance. Can be done prior to 
initial boot just after generation of the default configuration.nix & 
hardware-configuration.nix. It can also simply replace configuration in any 
current instance.

If you need assistance installing NixOS prior to this repository, you should 
head on over to the [NixOS Wiki](https://nixos.wiki/wiki/NixOS_Installation_Guide).

Once you have a working NixOS install, clone/download the repo into a suitable 
directory (I clone into ~/nixos-dotfiles). Then rebuild your system with the 
following commands.

```bash
sudo nixos-rebuild switch \
--experimental-features 'nix-command flakes' \
--flake ~/path/to/repo#hostname
```

Note, the path should go to the repo not the standard /etc/nixos directory, and 
hostname is `slimbook-nixos` by default, this can be changed in ./configuration.nix 
but then must be updated in ./flake.nix as well.

After initial rebuild the system can be rebuilt with the above command but 
omitting `--experimental-features 'nix-command flakes'`.
