{ pkgs, ... }:
{
  imports = [
    ../tui
    (import ../tui/git.nix {
      userName = "gibbz00";
      userEmail = "gabrielhansson00@gmail.com";
    })
  ];

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.11";
}
