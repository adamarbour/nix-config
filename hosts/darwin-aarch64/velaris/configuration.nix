{ inputs, pkgs, ... }:
let
  user = "aarbour";
in {
  users.users."${user}" = {
    home = /Users/${user};
    shell = pkgs.fish;
    description = "${user}";
    uid = 501;
  };
  users.knownUsers = [ "${user}" ];

  # leverage nix-homebrew flake
  nix-homebrew = {
    enable = true;
    inherit user;
  };

  # home manager
  home-manager.useGlobalPkgs = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
  home-manager.users."${user}" = import ./home.nix;

  # system packages - TODO: Move out
  environment.systemPackages = with pkgs; [
    # GUI
    # CMD
    just
    home-manager
    neovim
  ];

  # programs
  programs = {
    fish = {
      enable = true;
      vendor.completions.enable = true;
      vendor.config.enable = true;
      vendor.functions.enable = true;
    };
  };

  system.defaults.dock.persistent-apps = [
    "/Applications/Ghostty.app"
    "/Applications/Obsidian.app"
    "/System/Applications/Reminders.app"
    "/Applications/Neovide.app"
    "/Applications/Miro.app"
    "/Applications/Figma.app"
    "/System/Applications/Mail.app"
    "/System/Applications/Calendar.app"
    "/Applications/Zen.app"
    "/Applications/Microsoft Edge.app"
    "/Applications/Thorium.app"
    "/System/Applications/Music.app"
    "/Applications/OBS.app"
    "/Applications/RawTherapee.app"
    "/System/Applications/Photos.app"
    "/Applications/Photomator.app"
    "/Applications/Pixelmator Pro.app"
    "/Applications/Moonlight.app"
  ];

  nix.optimise.automatic = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    warn-dirty = false;
    trusted-users = [ "root" "${user}" "@wheel" "@admin" ];
    ## Reasonable defaults...
    connect-timeout = 5;
    log-lines = 25;
    min-free = 128000000; # 128MB
    max-free = 1000000000; # 1GB
  };
  nixpkgs.config.allowUnfree = true;

  nix.package = pkgs.nix;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.extraOptions = ''
    extra-platforms = x86_64-darwin aarch64-darwin
  '';

####### DO NOT TOUCH #######
  system.stateVersion = 5;
####### DO NOT TOUCH #######
}