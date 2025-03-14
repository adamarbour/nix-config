{
  description = "Everything Zen...";

  outputs = inputs@{ self, nixpkgs, unstable, nixpkgs-darwin, nix-darwin, home-manager }:
  {
    
    darwinConfigurations."velaris" = nix-darwin.lib.darwinSystem {
      modules = [ ./machines/velaris ];
    };

  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
