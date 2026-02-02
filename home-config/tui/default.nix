{ ... }:
{
  imports = [
    ./readline.nix
    ./nordic-locale.nix
  ];

  # XDG base directory spec adherence
  xdg.enable = true;
  xdg.cacheHome = "~/.local/cache";
  home.preferXdgDirectories = true;
}
