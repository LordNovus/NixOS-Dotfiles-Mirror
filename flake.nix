{
  description = "My nixos setup for my slimbook laptop";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # NUR for firefox extensions
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, nur, ... } @ inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.slimbook-nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ./noctalia.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.novus = import ./home.nix;
              backupFileExtension = "bak";
              extraSpecialArgs = { inherit inputs; };
            };
          }
          nur.modules.nixos.default
          ({ pkgs, ... }: {
            # environment.systemPackages = [ pkgs.nur.repos.rycee.firefox-addons ];
          })
        ];
      };
    };
}
