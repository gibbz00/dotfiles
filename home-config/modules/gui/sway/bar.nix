{ config, ... }:
{
  wayland.windowManager.sway.config.bars = [
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

  xdg.configFile."sway/bar.sh" = {
    executable = true;
    text = ''
      #!/bin/sh
      _date=$(date +'%Y-%m-%d %H:%M:%S')
      _battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)
      _kb_layout=$(swaymsg -t get_inputs \
        | jq -r ".[] | select(.type==\"keyboard\") | .xkb_active_layout_name" \
        | head -n1)
      echo "$_date $_battery_percentage | $_kb_layout"
    '';
  };
}
