{ ... }:
{
  imports = [
    ../../modules/tui/default.nix
    ../../users/gibbz/tui.nix
    (import ../../modules/gui/default.nix { autoStartFromTty = 1; })
  ];

  home.stateVersion = "25.11";
}
