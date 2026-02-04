{ ... }:
{
  imports = [
    ../../modules/tui/default.nix
    ../../users/gh/tui.nix
    ../../modules/gui/default.nix
  ];

  home.stateVersion = "25.11";
}
