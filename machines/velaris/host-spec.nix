{ lib, ... }:

{
  options.hostUser = lib.mkOption {
    type = lib.types.str;
    default = "aarbour";
  };
  options.hostMachineName = lib.mkOption {
    type = lib.types.str;
    default = "velaris";
  };
}