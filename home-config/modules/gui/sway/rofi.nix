{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    clipman
    wl-clipboard
    wtype
    rofimoji
  ];

  wayland.windowManager.sway.config = {
    keybindings = {
      "$mod+o" = "exec rofi -show drun -show-icons";
      "$mod+w" = "exec rofi -show window -show-icons";

      "$mod+d" = "exec --no-startup-id \"$XDG_CONFIG_HOME/rofi/exit.sh\"";

      "$mod+c" = "exec clipman pick --tool rofi";
      "$mod+Shift+c" = "exec clipman pick --tool rofi --err-on-no-selection && wtype -M ctrl -M shift v";
      "$mod+Control+c" = "exec clipman clear --all";

      "$mod+e" = ''
        exec --no-startup-id rofimoji \
             --selector-args="-theme $XDG_CONFIG_HOME/rofi/grid.rasi" \
             --hidden-descriptions --max-recent 5
      '';
    };
    startup = [ { command = "wl-paste -t text --watch clipman store --no-persist --max-items=200"; } ];
  };

  xdg.configFile."rofi/exit.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      ANS="$(echo "Lock|Logout|Reboot|Shutdown" \
        | rofi -dmenu -sep "|" -p 'System Exit' -theme-str 'listview { scrollbar: false; }'
      )"

      case "$ANS" in
        *Lock) swaylock ;;
        *Logout*) swaymsg exit ;;
        *Reboot) systemctl reboot ;;
        *Shutdown) systemctl -i poweroff ;;
      esac
    '';
  };

  xdg.configFile."rofi/grid.rasi".text = ''
    @import "config"

    textbox {
      vertical-align:   0.5;
      horizontal-align: 0.5;
    }

    listview {
      columns:       9;
      lines:         7;
      cycle:         true;
      dynamic:       true;
      layout:        vertical;
      flow:          horizontal;
      reverse:       false;
      fixed-height:  true;
      fixed-columns: true;
    }

    element {
      orientation: vertical;
    }

    element-text {
      vertical-align:   0.5;
      horizontal-align: 0.5;
      font: "Nono Emoji 24";
    }
  '';

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
