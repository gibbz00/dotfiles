{ pkgs, ... }:
{
  imports = [
    ../tui
  ];

  home.packages = with pkgs; [
    docker-compose
  ];

  home.stateVersion = "25.11";
}
