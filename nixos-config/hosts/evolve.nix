{ pkgs, flake-inputs, ... }:
{
  imports = [
    ../modules/default.nix
    ../modules/uefi-bootloader.nix
    ../modules/wireless-networking.nix
    ../modules/audio.nix
    ../modules/docker.nix
    ../modules/stylix.nix
    ../modules/sway.nix
    (import ../modules/normal-user.nix {
      userName = "gibbz";
      hashedPassword = "$y$j9T$MQXA5mg/uXaH3CvJ0i1qP/$llbGFH50xgXPB2Qe7HE.Q0xDOrRxmPEPa0Ka97nt5R9";
      extraGroups = [
        "docker"
        "wheel"
      ];
    })
    (import ../modules/normal-user.nix {
      userName = "gh";
      hashedPassword = "$y$j9T$H9jWdmKveSuHjcTUk/B5b/$RSRUkln89GzuA3YCSaAClbuR/T3jKvPphthTNSlQts5";
      extraGroups = [
        "docker"
        "wheel"
      ];
    })
  ];

  users.users.root = {
    initialHashedPassword = "$y$j9T$1m20HcCl7Np8K4xtVkhFP1$m.p7mrYKVn6qrc2pH4OoCRr0E5bg2N3Aq5KgaIApwG1";
  };

  system.stateVersion = "25.11";
}
