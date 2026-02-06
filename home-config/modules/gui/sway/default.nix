{
  autoStartFromTty,
}:
{ config, pkgs, ... }:
{
  imports = [
    ./rofi.nix
    ./fnott.nix
    ./screenshot.nix
    ./opacity.nix
  ];

  # XDG base directory touchups
  xresources.path = "${config.xdg.configHome}/x11/.Xresources";

  programs.bash.profileExtra = ''
    [[ ! $DISPLAY && XDG_VTNR -eq ${pkgs.lib.toString autoStartFromTty} ]] && exec sway
  '';

  home.packages = with pkgs; [
    upower
    brightnessctl
    # for XDG portal screen record region selections
    slurp
  ];

  programs.swaylock = {
    enable = true;
    settings = {
      indicator-idle-visible = true;
      indicator-thickness = 13;
      indicator-x-position = 100;
      indicator-y-position = 100;
    };
  };

  wayland.windowManager.sway =
    let
      mod = "Mod4";
      ws_bind =
        { k, v }:
        let
          inherit (pkgs.lib) toString forEach range;
          workspaces = forEach (range 1 9) (n: toString n);
        in
        builtins.listToAttrs (
          forEach workspaces (ws: {
            name = k ws;
            value = v ws;
          })
        );
    in
    {
      enable = true;
      # Recommended by docs for passing user
      # environment when starteswaylock  d from a TTY.
      systemd.variables = [ "--all" ];

      extraConfigEarly = ''
        set $mod ${mod}
        set $up up
        set $down down
        set $left left
        set $right right
      '';
      config = {
        modifier = mod;
        floating.modifier = mod;

        seat."*".hide_cursor = "when-typing enable";

        window = {
          border = 0;
          titlebar = false;
        };
        floating = {
          border = 0;
          titlebar = false;
        };
        gaps = {
          smartGaps = true;
          inner = 8;
          outer = 4;
        };

        input."type:keyboard" = {
          # - toggle between layout with alt+shift
          # - compose required for special characters to work on ZMK
          xkb_options = "grp:alt_space_toggle,compose:ralt";
          xkb_layout = "us,se";
        };

        bars = [
          (
            config.stylix.targets.sway.exportedBarConfig
            // {
              position = "bottom";
              trayOutput = "none";
              statusCommand = "while \"$XDG_CONFIG_HOME/sway/bar.sh\"; do sleep 1; done";
              mode = "hide";
              extraConfig = ''
                modifier $mod+ctrl
              '';
            }
          )
        ];

        keybindings =
          ws_bind {
            k = ws: "$mod+${ws}";
            v = ws: "workspace ${ws}";
          }
          // ws_bind {
            k = ws: "$mod+Shift+${ws}";
            v = ws: "move container to workspace ${ws}";
          }
          // {
            "$mod+q" = "kill";
            "$mod+f" = "fullscreen toggle";
            "$mod+space" = "floating toggle";
            "$mod+Shift+z" = "move scratchpad";
            "$mod+z" = "scratchpad show";

            # Navigation
            "$mod+bracketleft" = "workspace prev";
            "$mod+bracketright" = "workspace next";
            "$mod+Tab" = "workspace back_and_forth";
            "$mod+Shift+Tab" = "move container to workspace back_and_forth; workspace back_and_forth";
            # Layouts
            "$mod+Shift+t" = "layout tabbed";
            "$mod+Shift+s" = "layout stacking";
            "$mod+Shift+v" = "layout toggle split";
            "$mod+v" = "split toggle";
            # Sizing
            "$mod+Control+$down" = "resize shrink height 90 px";
            "$mod+Control+$up" = "resize grow height 90 px";
            "$mod+Control+$right" = "resize grow width  90 px";
            "$mod+Control+$left" = "resize shrink width  90 px";
            # Move float
            "$mod+Shift+$left" = "move left 90px";
            "$mod+Shift+$down" = "move down 90px";
            "$mod+Shift+$up" = "move up 90px";
            "$mod+Shift+$right" = "move right 90px";
            # Change focus
            "$mod+$left" = "focus left";
            "$mod+$down" = "focus down";
            "$mod+$up" = "focus up";
            "$mod+$right" = "focus right";
            "$mod+Shift+space" = "focus mode_toggle";

            # Exec
            "$mod+Return" = "exec footclient";

            "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";
            "XF86MonBrightnessUp" = "exec brightnessctl set 5%+";
          };
      };
    };

  xdg.portal = {
    enable = true;

    # https://github.com/emersion/xdg-desktop-portal-wlr/blob/master/README.md#running
    config.sway = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
    };

    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  xdg.configFile."sway/bar.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      _date=$(date +'%Y-%m-%d %H:%M:%S')
      _battery_percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 \
        | rg percentage \
        | cut -d ':' -f2 \
        | tr -d ' ')
      _kb_layout=$(swaymsg -t get_inputs \
        | jq -r ".[] | select(.type==\"keyboard\") | .xkb_active_layout_name" \
        | head -n1)
      echo "$_date $_battery_percentage | $_kb_layout"
    '';
  };
}
