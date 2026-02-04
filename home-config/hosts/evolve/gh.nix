{ ... }:
{
  imports = [
    ../../modules/tui/default.nix
    ../../users/gh/tui.nix
    ../../modules/gui/sway.nix
  ];

  home.stateVersion = "25.11";
}
