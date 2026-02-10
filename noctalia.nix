{ pkgs, inputs, ... }:

{
  home-manager.users.novus = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia-shell = {
      enable = true;
    };
  };
}
