{ pkgs, ... }:
{
  nix.linux-builder = {
    enable = true;
    ephemeral = true;
    maxJobs = 4;
    config.virtualisation = {
      darwin-builder = {
        diskSize = 20 * 1024;
        memorySize = 6 * 1024;
      };
      cores = 6;
    };
    systems = [ "x86_64-linux" ];
    package = pkgs.darwin.linux-builder;
  };
  nix.settings.trusted-users = [ "@admin" ];
}