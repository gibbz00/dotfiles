{ pkgs, flake-inputs, ... }:
let
  rootPassword = "test";
  hostSshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZLVfPatp7YOYiWAmpDMibN9CNLCmqEOhWZ8bsqvENa gibbz@evolve-leissner";
in
{
  users.users.gibbz.isNormalUser = true;
  home-manager.users.gibbz = import "${flake-inputs.self}/home-config/users/gibbz.nix";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.root = {
    initialPassword = rootPassword;
    openssh.authorizedKeys.keys = [ hostSshKey ];
  };

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
