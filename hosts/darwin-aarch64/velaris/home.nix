{ lib, pkgs, ... }:
{
  programs.git = {
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

  programs.fish = {
    enable = true;
    generateCompletions = true;
  };
  programs.nushell.enable = true;

  programs.starship = {
    enable = true; 
    enableFishIntegration = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_status"
        "$character"
      ];
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  news.display = "silent";
  manual.html.enable = true;
  xdg.enable = true;

  home.username = lib.mkDefault "aarbour";
  home.homeDirectory = lib.mkDefault "/Users/aarbour";

  programs.man.generateCaches = true;
  programs.home-manager.enable = true;

####### DO NOT TOUCH #######
  home.stateVersion = "24.11";
####### DO NOT TOUCH #######
}