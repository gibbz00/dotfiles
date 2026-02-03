{ pkgs, ... }:
{
  imports = [
    ../tui
    (import ../tui/git.nix {
      userName = "gibbz00";
      userEmail = "gabrielhansson00@gmail.com";
    })
  ];

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      setEnv = {
        TERM = "xterm-256color";
      };
    };
  };

  home.packages = with pkgs; [
  ];

  home.stateVersion = "25.11";
}
