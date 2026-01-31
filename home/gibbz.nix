{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cowsay
  ];

  home.stateVersion = "25.11";
}
