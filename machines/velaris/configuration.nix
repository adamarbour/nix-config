{ ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.enable = false;
  nix.settings.experimental-features = "nix-command flakes";

  system.configurationRevision = self.rev or self.dirtyRev or null;
  system.stateVersion = 5;

}