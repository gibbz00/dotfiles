{
  autoStartFromTty,
}:
{ config, pkgs, ... }:
{
  imports = [
    ./stylix.nix
    (import ./sway/default.nix { inherit autoStartFromTty; })
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
    profiles.main.settings = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };

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

  ## XDG Open
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "text/html" = "firefox.desktop";
      "text/plain" = "Helix.desktop";
    };
  };
}
