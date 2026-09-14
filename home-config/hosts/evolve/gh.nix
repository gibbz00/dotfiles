{ ... }:
{
  imports = [
    ../../modules/tui/default.nix
    ../../modules/tui/agenix.nix
    ../../modules/tui/eduroam.nix
    ../../users/gh/tui.nix
    (import ../../modules/gui/default.nix { autoStartFromTty = 2; })
    ../../users/gh/gui.nix
  ];

  home.stateVersion = "25.11";
}
