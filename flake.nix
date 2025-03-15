{
  description = "Everything Zen...";

  outputs = inputs@{
    self,
    nixpkgs,
    unstable,
    nixpkgs-darwin,
    nix-darwin,
    mac-app-util,
    nix-homebrew,
    home-manager
  }: {
    
    darwinConfigurations."velaris" = nix-darwin.lib.darwinSystem {
      modules = [
        mac-app-util.darwinModules.default
        nix-homebrew.darwinModules.nix-homebrew
        ./machines/velaris
      ];
    };

  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    # Mac app utilities
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs-darwin";
    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
}
