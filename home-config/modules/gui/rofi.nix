{ config, ... }:
{
  wayland.windowManager.sway.config.keybindings = {
    "$mod+o" = "exec rofi -show drun -show-icons";
  };

  programs.rofi = {
    enable = true;
    theme =
      let
        inherit (config.lib.formats.rasi) mkLiteral;
      in
      {
        window = {
          border = 0;
          padding = 20;
        };
        mainbox = {
          border = 0;
          padding = 10;
        };
        message = {
          border = 1;
          padding = mkLiteral "10 2%";
        };
        prompt = {
          padding = 5;
        };
        listview = {
          spacing = 2;
          scrollbar = true;
        };
        element = {
          padding = 5;
        };
        sidebar = {
          padding = mkLiteral "1% 2% 2%";
        };
        scrollbar = {
          width = mkLiteral "4px";
          handle-width = mkLiteral "8px";
        };
        button = {
          padding = mkLiteral "8 0";
        };
        inputbar = {
          padding = mkLiteral "0 1 3";
        };
        entry = {
          spacing = 5;
          border = 0;
          padding = mkLiteral "5 5";
        };
      };
  };
}
