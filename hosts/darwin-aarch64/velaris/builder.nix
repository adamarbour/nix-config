{ ... }:
{
  nix.linux-builder = {
    enable = true;
    ephemeral = true;
    maxJobs = 4;
    config.virtualisation = {
      darwin-builder = {
        diskSize = 20 * 1024;
        memorySize = 4 * 1024;
      };
      cores = 4;
    };
  };
  nix.settings.trusted-users = [ "@admin" ];
}