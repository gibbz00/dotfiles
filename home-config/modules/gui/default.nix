{
  autoStartFromTty,
}:
{ config, pkgs, ... }:
{
  imports = [
    (import ./sway.nix { inherit autoStartFromTty; })
    ./stylix.nix
    ./rofi.nix
    ./sway-rofi-screenshot.nix
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
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      DefaultDownloadDirectory = "${config.xdg.userDirs.download}";
    };
  };

  ## Other Packages
  programs.zathura.enable = true;
}
