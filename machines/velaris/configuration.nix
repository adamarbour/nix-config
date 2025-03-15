{ pkgs, config, ... }:
{
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  nix-homebrew = {
    enable = true;
    user = "aarbour";
  };

  environment.systemPackages = with pkgs; [
    # GUI
    obsidian
    # CMD
    just
    neovim
  ];
  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "iina"
      "the-unarchiver"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };

  fonts.packages = [];

  nixpkgs.hostPlatform = "aarch64-darwin"; 

####### DO NOT TOUCH #######
  system.stateVersion = 5;
  nix.enable = false;  # Disabled because we're using Determinate's installation
####### DO NOT TOUCH #######
}