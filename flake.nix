{
  description = "Everything Zen...";

  outputs = inputs@{
    self,
    nixpkgs,
    unstable,
    nixpkgs-darwin,
    determinate,
    nix-darwin,
    nix-homebrew,
    sops-nix,
    nix-secrets,
    home-manager
  }: {

    darwinConfigurations."velaris" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./machines/velaris ];
    };

    homeConfigurations = {
      "aarbour@velaris" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs;};
        modules = [ ./machines/velaris/home.nix ];
      };
    };

  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";

    # Nix-Darwin - MacOS
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
    nix-darwin.url = "github:LnL7/nix-darwin/nix-darwin-24.11";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs-darwin";
    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-secrets = {
      url = "git+ssh://git@github.com/adamarbour/nix-secrets?shallow=1&ref=main";
      flake = false;
    };
  };
}
