{
  description = "Everything Zen...";
# OUTPUTS
  outputs = inputs@{ 
    self,
    nixpkgs,
    unstable,
    nixpkgs-darwin,
    nix-darwin,
    nix-homebrew,
    home-manager,
    sops-nix
  }:
  {
  # DARWIN CONFIGS
    darwinConfigurations."velaris" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./hosts/darwin-aarch64/velaris ];
    };

  };
# INPUTS
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # nix-darwin
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    ## nix-homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # sops-nix
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };
}
