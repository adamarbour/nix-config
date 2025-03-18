{ inputs, ... }:
{
  imports = [
    inputs.determinate.nixosModules.default
    inputs.nix-homebrew.darwinModules.nix-homebrew
    inputs.home-manager.darwinModules.home-manager
    inputs.sops-nix.darwinModules.sops
    ./host-spec.nix
    ./configuration.nix
  ];
}
