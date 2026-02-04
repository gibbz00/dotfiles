{ ... }:
{
  imports = [
    ../../modules/tui/default.nix
    ../../users/gibbz/tui.nix
    ../../modules/gui/default.nix
  ];

  home.stateVersion = "25.11";
}
