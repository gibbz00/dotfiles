{ pkgs, ... }:
{
  imports = [
    ../nordic-locale.nix
  ];

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.11";
}
