{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.firewall.allowedTCPPorts = [
    22
  ];

  users.users.root = {
    initialPassword = "test";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZLVfPatp7YOYiWAmpDMibN9CNLCmqEOhWZ8bsqvENa gibbz@evolve-leissner"
    ];
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
  ];

  system.stateVersion = "25.11";
}
