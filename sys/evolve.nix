{ pkgs, ... }:
let
  rootPassword = "test";
  hostSshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZLVfPatp7YOYiWAmpDMibN9CNLCmqEOhWZ8bsqvENa gibbz@evolve-leissner";
in
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.root = {
    initialPassword = rootPassword;
    openssh.authorizedKeys.keys = [ hostSshKey ];
  };

  # FIXME: separate from pure sys configuration
  users.users.gibbz.isNormalUser = true;

  services.openssh = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    git
    helix
  ];

  environment.variables.EDITOR = "hx";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
