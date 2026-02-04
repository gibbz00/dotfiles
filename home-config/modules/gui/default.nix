{ ... }:
{
  imports = [
    ./sway.nix
    ./stylix.nix
  ];

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      scrollback.lines = 2000;
    };
  };
}
