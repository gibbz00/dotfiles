{ pkgs, ... }:
{
  imports = [
    ../../modules/tui/git.nix
    ../../modules/tui/rustup.nix
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
}
