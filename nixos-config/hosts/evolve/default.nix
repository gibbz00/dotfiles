{ pkgs, flake-inputs, ... }:
{
  imports = [
    ../../modules/default.nix
    ../../modules/uefi-bootloader.nix
    ../../modules/wireless-networking.nix
    ../../modules/audio.nix
    ../../modules/docker.nix
    ../../modules/stylix.nix
    ../../modules/sway.nix
    (import ../../modules/normal-user.nix {
      userName = "gibbz";
      hashedPassword = "$y$j9T$MQXA5mg/uXaH3CvJ0i1qP/$llbGFH50xgXPB2Qe7HE.Q0xDOrRxmPEPa0Ka97nt5R9";
      extraGroups = [
        "docker"
        "wheel"
        # for way-displays
        "input"
      ];
    })
    (import ../../modules/normal-user.nix {
      userName = "gh";
      hashedPassword = "$y$j9T$H9jWdmKveSuHjcTUk/B5b/$RSRUkln89GzuA3YCSaAClbuR/T3jKvPphthTNSlQts5";
      extraGroups = [
        "docker"
        "wheel"
        # for way-displays
        "input"
      ];
    })
  ];

  hardware.bluetooth.enable = true;

  # Required for modification by gh's `vpn-slice`
  environment.etc.hosts.mode = "0644";

  users.users.root = {
    initialHashedPassword = "$y$j9T$4t7xt45hJsnvW67oU1C2c/$syarYVJrnEZnGdMAIomyqoGLKOk2XxEockI8QYgdl.7";
  };

  system.stateVersion = "25.11";
}
