{ pkgs, lib, ... }:
{

  programs = {

    git = {
      enable = true;
      userName  = "Adam Arbour";
      userEmail = "adam.arbour@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
      };
      ignores = [
        ".DS_Store"
      ];
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

  home.packages = with pkgs; [
    age
    sops
    ssh-to-age
  ];

  home.username = lib.mkDefault "aarbour";
  home.homeDirectory = lib.mkDefault "/Users/aarbour";

####### DO NOT TOUCH #######
  home.stateVersion = "24.11";
####### DO NOT TOUCH #######
}
