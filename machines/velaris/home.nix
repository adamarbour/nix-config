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

    fish = {
      enable = true;
      generateCompletions = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    man.generateCaches = true;
    home-manager.enable = true;
  };

  xdg.enable = true;

  home.username = lib.mkDefault "aarbour";
  home.homeDirectory = lib.mkDefault "/Users/aarbour";
  
  home.packages = with pkgs; [
    age
    sops
    ssh-to-age
  ];

####### DO NOT TOUCH #######
  home.stateVersion = "24.11";
####### DO NOT TOUCH #######
}
