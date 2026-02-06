{ ... }:
{
  imports = [
    ../../modules/tui/default.nix
    ../../users/gh/tui.nix
    (import ../../modules/gui/default.nix { autoStartFromTty = 2; })
  ];

  home.stateVersion = "25.11";
}
