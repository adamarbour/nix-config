{ pkgs, lib, ... }:
{
  home = {
    username = lib.mkDefault "aarbour";
    homeDirectory = lib.mkDefault "/Users/aarbour";
  };

  programs = {

    git = {
      enable = true;
      userName  = "Adam Arbour";
      userEmail = "adam.arbour@gmail.com";
    };

    zsh = {
      enable = true;
      enableCompletion = false;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    man.generateCaches = true;
    home-manager.enable = true;
  };

  xdg.enable = true;

####### DO NOT TOUCH #######
  home.stateVersion = "24.11";
####### DO NOT TOUCH #######
}
