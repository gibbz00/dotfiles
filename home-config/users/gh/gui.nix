{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains.idea
    onlyoffice-desktopeditors
  ];
}
