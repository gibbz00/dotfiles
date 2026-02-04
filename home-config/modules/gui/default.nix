{ config, pkgs, ... }:
{
  imports = [
    ./sway.nix
    ./stylix.nix
  ];

  ## Fonts
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.symbols-only
  ];

  ## Terminal Emulator
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      scrollback.lines = 2000;
    };
  };

  ## Firefox
  programs.firefox = {
    enable = true;
    policies = {
      DefaultDownloadDirectory = "${config.xdg.userDirs.download}";
    };
  };
}
