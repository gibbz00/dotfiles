{ ... }:
{
  imports = [
    ../../modules/tui/default.nix
    ../../users/gh/tui.nix
  ];

  home.stateVersion = "25.11";
}
