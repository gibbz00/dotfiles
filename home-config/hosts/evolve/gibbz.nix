{ ... }:
{
  imports = [
    ../../modules/tui/default.nix
    ../../users/gibbz/tui.nix
    ../../modules/gui/sway.nix
  ];

  home.stateVersion = "25.11";
}
