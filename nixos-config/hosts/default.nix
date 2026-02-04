{ hostName }:
{ ... }:
{
  imports = [
    ../hosts/${hostName}.nix
  ];

  networking.hostName = hostName;
}
