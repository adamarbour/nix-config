{ config, pkgs, lib, ... }:
let
  # TODO: Figure out how to declaratively set the profile photo
  imgProfile = ../../profiles/me.jpg; # Profile photo
in
{
  home.file = {
    "${config.xdg.configHome}/me.jpg".source = imgProfile;
  };

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

    nushell = {
      enable = true;
    };

    starship = {
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

  news.display = "silent";
  manual.html.enable = true;

####### DO NOT TOUCH #######
  home.stateVersion = "24.11";
####### DO NOT TOUCH #######
}
