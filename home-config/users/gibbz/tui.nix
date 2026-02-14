{ pkgs, ... }:
{
  imports = [
    ../../modules/tui/git.nix
  ];

  programs.gcc.enable = true;
  home.packages = with pkgs; [
    rustup
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
