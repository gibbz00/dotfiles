{ pkgs, ... }:
{
  imports = [
    ../tui
    (import ../tui/git.nix {
      userName = "Gabriel Hansson";
      userEmail = "gh@leissner.se";
      defaultBranch = "master";
    })
  ];

  home.packages = with pkgs; [
    docker-compose
  ];

  home.stateVersion = "25.11";
}
