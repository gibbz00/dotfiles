{ pkgs, flake-inputs, ... }:
let
  hostSshKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZLVfPatp7YOYiWAmpDMibN9CNLCmqEOhWZ8bsqvENa gibbz@evolve-leissner";
  # Generated with `mkpasswd`
  rootPassword = "$y$j9T$1m20HcCl7Np8K4xtVkhFP1$m.p7mrYKVn6qrc2pH4OoCRr0E5bg2N3Aq5KgaIApwG1";
  userPassword = "$y$j9T$J6DE/phOFME5IrDONaOo41$rpBvbN.VtwJyWDZCf4hOSmNl6MVRiIkH58rl6xaSRg2";

in
{
  users.users.gibbz = {
    isNormalUser = true;
    initialHashedPassword = userPassword;
  };

  home-manager.users.gibbz = import "${flake-inputs.self}/home-config/users/gibbz.nix";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.root = {
    initialHashedPassword = rootPassword;
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
