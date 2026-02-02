{ pkgs, ... }:
{
  imports = [
    ../tui
  ];

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.11";
}
