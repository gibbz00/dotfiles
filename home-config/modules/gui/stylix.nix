{
  flake-inputs,
  config,
  pkgs,
  lib,
  ...
}:
{
  disabledModules = [
    "${flake-inputs.stylix}/modules/helix/hm.nix"
    "${flake-inputs.stylix}/modules/firefox/hm.nix"
  ];

  stylix.targets.rofi.alternatePattern = false;

  # Auto-enabled by sys module
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";

    image = "${flake-inputs.self}/home-config/assets/wallpaper_penguin.jpg";

    icons = {
      enable = true;
      package = pkgs.tela-icon-theme;
      light = "Tela-grey-light";
      dark = "Tela-grey-dark";
    };

    cursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Nono Sans";
      };

      monospace = {
        package = pkgs.noto-fonts;
        name = "Noto Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
