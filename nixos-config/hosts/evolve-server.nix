{ pkgs, flake-inputs, ... }:
{
  imports = [
    ../modules/default.nix
    ../modules/uefi-bootloader.nix
    ../modules/openssh.nix
    (import ../modules/normal-user.nix {
      userName = "gibbz";
      hashedPassword = "$y$j9T$MQXA5mg/uXaH3CvJ0i1qP/$llbGFH50xgXPB2Qe7HE.Q0xDOrRxmPEPa0Ka97nt5R9";
      extraGroups = [ "wheel" ];
    })
  ];

  users.users.root = {
    initialHashedPassword = "$y$j9T$27VazV3DP9UOVFM7k61400$ilW3r6GVazy28Qxv/ofx0I/6PrPFRLT7t.Mw9a.BerB";
  };

  system.stateVersion = "25.11";
}
