{ ... }:
{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    # Related to automatic garbage collection efforts defined in nix.gc
    systemd-boot.configurationLimit = 10;
  };
}
