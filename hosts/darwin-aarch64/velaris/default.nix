{ inputs, ... }:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.home-manager.darwinModules.home-manager
    inputs.sops-nix.darwinModules.sops
    ./configuration.nix
    ./homebrew.nix
    ./system-defaults.nix
    ./builder.nix
  ];
}
