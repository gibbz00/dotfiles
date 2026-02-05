{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    upower
  ];

  wayland.windowManager.sway =
    let
      mod = "Mod4";
    in
    {
      enable = true;
      # Recommended by docs for passing user
      # environment when started from a TTY.
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

        gaps = {
          smartGaps = true;
          inner = 8;
          outer = 4;
        };

        window.border = 0;
        floating.border = 0;

        startup = [
          { command = "foot"; }
        ];
      };
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
