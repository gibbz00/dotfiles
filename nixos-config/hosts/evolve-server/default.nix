{ pkgs, flake-inputs, ... }:
{
  # networking.hostName = "evolve-server";

  imports = [
    ../../modules/default.nix
    ../../modules/uefi-bootloader.nix
    ../../modules/openssh.nix
    (import ../../modules/normal-user.nix {
      userName = "gibbz";
      hashedPassword = "$y$j9T$MQXA5mg/uXaH3CvJ0i1qP/$llbGFH50xgXPB2Qe7HE.Q0xDOrRxmPEPa0Ka97nt5R9";
      extraGroups = [ "wheel" ];
    })
  ];

  users.users.root = {
    initialHashedPassword = "$y$j9T$PWmaOgV7kLK3seqjRM9vW/$v1EBFlFq2MQ3ky6Tof0W7qcqy5mEikW7GbKMJYDkw0A";
  };

  system.stateVersion = "25.11";
}
