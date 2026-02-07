{ hostName }:
{ ... }:
{
  imports = [
    ../hosts/${hostName}/default.nix
    ../hosts/${hostName}/hardware.nix
  ];

  networking.hostName = hostName;
}
